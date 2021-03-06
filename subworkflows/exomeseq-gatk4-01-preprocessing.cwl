#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
requirements:
  ScatterFeatureRequirement: {}
  SchemaDefRequirement:
    types:
      - $import: ../types/FASTQReadPairType.yml
inputs:
  # Intervals should come from capture kit in bed format
  intervals: File[]?
  interval_padding: int?
  # target intervals in picard interval_list format (created from intervals bed file)
  target_interval_list: File
  # bait intervals in picard interval_list format
  bait_interval_list: File
  # Read samples, fastq format
  # NOTE: GATK best practices recommends unmapped SAM/BAM files
  read_pair:
    type: ../types/FASTQReadPairType.yml#FASTQReadPairType
  # reference genome, fasta
  # NOTE: GATK can't handle compressed fasta reference genome
  reference_genome:
    type: File
    secondaryFiles:
    - .amb
    - .ann
    - .bwt
    - .pac
    - .sa
    - .fai
    - ^.dict
  # Number of threads to use for mapping
  threads: int
  # Read Group annotations
  # Can be the project name
  library: string
  # e.g. Illumina
  platform: string
  known_sites:
    type: File[] # vcf files of known sites, with indexing
    secondaryFiles:
    - .idx
  resource_dbsnp:
    type: File
    secondaryFiles:
    - .idx
outputs:
  fastp_html_report:
    type: File
    outputSource: fastp/html_report
  fastp_json_report:
    type: File
    outputSource: fastp/json_report
  markduplicates_bam:
    type: File
    outputSource: mark_duplicates/output_dedup_bam_file
  markduplicates_metrics:
    type: File
    outputSource: mark_duplicates/output_metrics_file
  # Recalibration
  recalibration_table:
    type: File
    outputSource: recalibrate_01_analyze/output_recalibration_report
  recalibrated_reads:
    type: File
    outputSource: recalibrate_02_apply_bqsr/output_recalibrated_bam
  raw_variants:
    type: File
    outputSource: variant_calling/output_variants
    doc: "VCF file from per sample variant calling"
  haplotypes_bam:
    type: File
    outputSource: variant_calling/output_bam
    doc: "BAM file containing assembled haplotypes and locally realigned reads"
steps:
  file_pair_details:
    run: ../utils/extract-named-file-pair-details.cwl
    in:
       read_pair: read_pair
       library: library
       platform: platform
    out:
       - reads
       - read_pair_name
       - read_group_header
  generate_sample_filenames:
    run: ../utils/generate-sample-filenames.cwl
    in:
      sample_name: file_pair_details/read_pair_name
    out:
      - combined_reads_output_filenames
      - trimmed_reads_output_filenames
      - mapped_reads_output_filename
      - sorted_reads_output_filename
      - dedup_reads_output_filename
      - dedup_metrics_output_filename
      - recal_reads_output_filename
      - recal_table_output_filename
      - raw_variants_output_filename
      - haplotypes_bam_output_filename
  combine_reads:
    run: ../tools/concat-gz-files.cwl
    requirements:
      - class: ResourceRequirement
        coresMin: 1
        ramMin: 1024
    scatter: [files, output_filename]
    scatterMethod: dotproduct
    in:
       files: file_pair_details/reads
       output_filename: generate_sample_filenames/combined_reads_output_filenames
    out:
       - output
  fastp:
    run: ../tools/fastp-pe.cwl
    requirements:
    - class: ResourceRequirement
      coresMin: 4
      ramMin: 2048
    in:
      reads: combine_reads/output
      trimmed_reads_filenames: generate_sample_filenames/trimmed_reads_output_filenames
      report_base_filename: file_pair_details/read_pair_name
      threads: { default: 4 }
    out:
      - trimmed_reads
      - html_report
      - json_report
  map:
    run: ../tools/gitc-bwa-mem-samtools.cwl
    requirements:
      - class: ResourceRequirement
        coresMin: $(inputs.threads)
        ramMin: 15336
        outdirMin: 12288
        tmpdirMin: 12288
    in:
      reads: fastp/trimmed_reads
      reference: reference_genome
      read_group_header: file_pair_details/read_group_header
      output_filename: generate_sample_filenames/mapped_reads_output_filename
      threads: threads
    out:
      - output_sorted_bam
  mark_duplicates:
    run: ../tools/GATK4/GATK4-MarkDuplicates.cwl
    requirements:
      - class: ResourceRequirement
        ramMin: 32768
        outdirMin: 12288
        tmpdirMin: 12288
    in:
      input_file: map/output_sorted_bam
      output_filename: generate_sample_filenames/dedup_reads_output_filename
      metrics_filename: generate_sample_filenames/dedup_metrics_output_filename
      validation_stringency: { default: "SILENT" }
      assume_sort_order: { default: "coordinate" }
      create_index: { default: "true" }
      optical_duplicate_pixel_distance: { default: 2500 }
      java_opt: { default: "-Xms4g" }
    out:
      - output_dedup_bam_file
      - output_metrics_file
  # Now recalibrate
  recalibrate_01_analyze:
    run: ../tools/GATK4/GATK4-BaseRecalibrator.cwl
    requirements:
      - class: ResourceRequirement
        ramMin: 12288
    in:
      reference: reference_genome
      input_bam: mark_duplicates/output_dedup_bam_file
      output_recalibration_report_filename: generate_sample_filenames/recal_table_output_filename
      known_sites: known_sites
      intervals: intervals
      interval_padding: interval_padding
      java_opt: { default: "-Xms4g" }
    out:
      - output_recalibration_report
  recalibrate_02_apply_bqsr:
    run: ../tools/GATK4/GATK4-ApplyBQSR.cwl
    requirements:
      - class: ResourceRequirement
        ramMin: 6144
    in:
      reference: reference_genome
      input_bam: mark_duplicates/output_dedup_bam_file
      output_recalibrated_bam_filename: generate_sample_filenames/recal_reads_output_filename
      intervals: intervals
      interval_padding: interval_padding
      bqsr_report: recalibrate_01_analyze/output_recalibration_report
      add_output_sam_program_record: { default: true }
      java_opt: { default: "-Xms3g" }
    out:
      - output_recalibrated_bam
  variant_calling:
    run: ../tools/GATK4/GATK4-HaplotypeCaller.cwl
    requirements:
      - class: ResourceRequirement
        coresMin: 1
        ramMin: 18432
    in:
      reference: reference_genome
      input_bam: recalibrate_02_apply_bqsr/output_recalibrated_bam
      # Naming your output file using the .g.vcf extension will automatically set the appropriate values  for --variant_index_type and --variant_index_parameter
      output_variants_filename: generate_sample_filenames/raw_variants_output_filename
      output_bam_filename: generate_sample_filenames/haplotypes_bam_output_filename
      intervals: intervals
      interval_padding: interval_padding
      annotation_groups: { default: ['StandardAnnotation','AS_StandardAnnotation'] }
      emit_ref_confidence: { default: "GVCF" }
      java_opt: { default: "-Xms7g" }
    out:
      - output_variants
      - output_bam

