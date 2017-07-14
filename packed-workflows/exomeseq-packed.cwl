{
    "cwlVersion": "v1.0", 
    "$graph": [
        {
            "class": "CommandLineTool", 
            "requirements": [
                {
                    "class": "EnvVarRequirement", 
                    "envDef": [
                        {
                            "envName": "PATH", 
                            "envValue": "/usr/local/bin/:/usr/bin:/bin"
                        }
                    ], 
                    "id": "#envvar-global.yml", 
                    "name": "#envvar-global.yml"
                }, 
                {
                    "class": "DockerRequirement", 
                    "dockerPull": "dukegcb/gatk_base", 
                    "dockerFile": "$import: GATK-Dockerfile\n", 
                    "id": "#GATK-docker.yml", 
                    "name": "#GATK-docker.yml"
                }
            ], 
            "inputs": [
                {
                    "type": "File", 
                    "inputBinding": {
                        "position": 1, 
                        "prefix": "-jar"
                    }, 
                    "id": "#GATK-AnalyzeCovariates.cwl/GATKJar"
                }, 
                {
                    "type": [
                        "null", 
                        "File"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--before"
                    }, 
                    "doc": "Input covariates table file for on-the-fly base quality score recalibration", 
                    "id": "#GATK-AnalyzeCovariates.cwl/before"
                }, 
                {
                    "type": "File", 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "-after"
                    }, 
                    "doc": "Data table after recalibration", 
                    "id": "#GATK-AnalyzeCovariates.cwl/inputTable_after"
                }, 
                {
                    "type": "File", 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "-before"
                    }, 
                    "doc": "Data table before recalibration", 
                    "id": "#GATK-AnalyzeCovariates.cwl/inputTable_before"
                }, 
                {
                    "type": [
                        "null", 
                        {
                            "type": "array", 
                            "items": "string", 
                            "inputBinding": {
                                "prefix": "--intervals"
                            }
                        }
                    ], 
                    "inputBinding": {
                        "position": 2
                    }, 
                    "doc": "One or more genomic intervals over which to operate", 
                    "id": "#GATK-AnalyzeCovariates.cwl/intervals"
                }, 
                {
                    "type": "string", 
                    "default": "-Xmx4g", 
                    "inputBinding": {
                        "position": 0
                    }, 
                    "id": "#GATK-AnalyzeCovariates.cwl/java_arg"
                }, 
                {
                    "type": [
                        "null", 
                        "boolean"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--lowMemoryMode"
                    }, 
                    "doc": "Reduce memory usage in multi-threaded code at the expense of threading efficiency", 
                    "id": "#GATK-AnalyzeCovariates.cwl/lowMemoryMode"
                }, 
                {
                    "type": "string", 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "-plots"
                    }, 
                    "doc": "name of the output plots file from analyzeCovariates", 
                    "id": "#GATK-AnalyzeCovariates.cwl/outputfile_recalibrationPlots"
                }, 
                {
                    "type": "File", 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "-R"
                    }, 
                    "secondaryFiles": [
                        ".amb", 
                        ".ann", 
                        ".bwt", 
                        ".pac", 
                        ".sa", 
                        ".fai", 
                        "^.dict"
                    ], 
                    "id": "#GATK-AnalyzeCovariates.cwl/reference"
                }
            ], 
            "outputs": [
                {
                    "type": "File", 
                    "outputBinding": {
                        "glob": "$(inputs.outputfile_recalibrationPlots)"
                    }, 
                    "id": "#GATK-AnalyzeCovariates.cwl/output_recalibrationPlots"
                }
            ], 
            "arguments": [
                {
                    "valueFrom": "$(runtime.tmpdir)", 
                    "position": 0, 
                    "separate": false, 
                    "prefix": "-Djava.io.tmpdir="
                }, 
                {
                    "valueFrom": "AnalyzeCovariates", 
                    "position": 2, 
                    "prefix": "-T"
                }
            ], 
            "baseCommand": [
                "java"
            ], 
            "doc": "GATK-AnalyzeCovariates.cwl is developed for CWL consortium\nIt generates a document called recalibration_plots.pdf containing plots that show how the reported base qualities match up to the\nempirical qualities calculated by the BaseRecalibrator.\n  Usage: java -jar GenomeAnalysisTK.jar -T AnalyzeCovariates -R reference.fa -before recal_data.table -after post_recal_data.table \\\n    -plots recalibration_plots.pdf\n", 
            "id": "#GATK-AnalyzeCovariates.cwl"
        }, 
        {
            "class": "CommandLineTool", 
            "requirements": [
                {
                    "$import": "#envvar-global.yml"
                }, 
                {
                    "$import": "#GATK-docker.yml"
                }
            ], 
            "inputs": [
                {
                    "type": "File", 
                    "inputBinding": {
                        "position": 1, 
                        "prefix": "-jar"
                    }, 
                    "id": "#GATK-ApplyRecalibration.cwl/GATKJar"
                }, 
                {
                    "type": [
                        "null", 
                        {
                            "type": "array", 
                            "items": "string"
                        }
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--intervals"
                    }, 
                    "doc": "One or more genomic intervals over which to operate", 
                    "id": "#GATK-ApplyRecalibration.cwl/intervals"
                }, 
                {
                    "type": "string", 
                    "default": "-Xmx8g", 
                    "inputBinding": {
                        "position": 0
                    }, 
                    "id": "#GATK-ApplyRecalibration.cwl/java_mem"
                }, 
                {
                    "type": "string", 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "-mode"
                    }, 
                    "doc": "specify if VQSR is called on SNPs or Indels", 
                    "id": "#GATK-ApplyRecalibration.cwl/mode"
                }, 
                {
                    "type": "string", 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "-o"
                    }, 
                    "id": "#GATK-ApplyRecalibration.cwl/outputfile_recalibrated_vcf"
                }, 
                {
                    "type": "File", 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "-recalFile"
                    }, 
                    "doc": "the recal file generated by VariantRecalibrator", 
                    "id": "#GATK-ApplyRecalibration.cwl/recal_file"
                }, 
                {
                    "type": "File", 
                    "secondaryFiles": [
                        ".fai", 
                        "^.dict"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "-R"
                    }, 
                    "doc": "reference genome", 
                    "id": "#GATK-ApplyRecalibration.cwl/reference"
                }, 
                {
                    "type": [
                        "null", 
                        "int"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "-nt"
                    }, 
                    "doc": "multithreading option", 
                    "id": "#GATK-ApplyRecalibration.cwl/threads"
                }, 
                {
                    "type": "File", 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "-tranchesFile"
                    }, 
                    "doc": "the tranches file generated by VariantRecalibrator", 
                    "id": "#GATK-ApplyRecalibration.cwl/tranches_file"
                }, 
                {
                    "type": "float", 
                    "default": 99.9, 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--ts_filter_level"
                    }, 
                    "doc": "filtering level default value is 99.9", 
                    "id": "#GATK-ApplyRecalibration.cwl/ts_filter_level"
                }, 
                {
                    "type": "File", 
                    "secondaryFiles": [
                        ".idx"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "-input"
                    }, 
                    "doc": "The raw input variants to be recalibrated", 
                    "id": "#GATK-ApplyRecalibration.cwl/variants"
                }
            ], 
            "outputs": [
                {
                    "type": "File", 
                    "outputBinding": {
                        "glob": "$(inputs.outputfile_recalibrated_vcf)"
                    }, 
                    "secondaryFiles": [
                        ".idx"
                    ], 
                    "doc": "The output recalibration VCF file", 
                    "id": "#GATK-ApplyRecalibration.cwl/output_recalibrated_vcf"
                }
            ], 
            "arguments": [
                {
                    "valueFrom": "$(runtime.tmpdir)", 
                    "position": 0, 
                    "separate": false, 
                    "prefix": "-Djava.io.tmpdir="
                }, 
                {
                    "valueFrom": "ApplyRecalibration", 
                    "position": 2, 
                    "prefix": "-T"
                }
            ], 
            "baseCommand": [
                "java"
            ], 
            "id": "#GATK-ApplyRecalibration.cwl"
        }, 
        {
            "class": "CommandLineTool", 
            "requirements": [
                {
                    "$import": "#envvar-global.yml"
                }, 
                {
                    "$import": "#GATK-docker.yml"
                }
            ], 
            "inputs": [
                {
                    "type": "File", 
                    "inputBinding": {
                        "position": 1, 
                        "prefix": "-jar"
                    }, 
                    "id": "#GATK-BaseRecalibrator.cwl/GATKJar"
                }, 
                {
                    "type": [
                        "null", 
                        "string"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--binary_tag_name"
                    }, 
                    "doc": "the binary tag covariate name if using it", 
                    "id": "#GATK-BaseRecalibrator.cwl/binary_tag_name"
                }, 
                {
                    "type": [
                        "null", 
                        "File"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--BQSR"
                    }, 
                    "doc": "Input covariates table file for on-the-fly base quality score recalibration", 
                    "id": "#GATK-BaseRecalibrator.cwl/bqsr"
                }, 
                {
                    "type": [
                        "null", 
                        "double"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--bqsrBAQGapOpenPenalty"
                    }, 
                    "doc": "BQSR BAQ gap open penalty (Phred Scaled). Default value is 40. 30 is perhaps better for whole genome call sets", 
                    "id": "#GATK-BaseRecalibrator.cwl/bqsrBAQGapOpenPenalty"
                }, 
                {
                    "type": [
                        "null", 
                        "string"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--covariate"
                    }, 
                    "doc": "One or more covariates to be used in the recalibration. Can be specified multiple times", 
                    "id": "#GATK-BaseRecalibrator.cwl/covariate"
                }, 
                {
                    "type": [
                        "null", 
                        "int"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--deletions_default_quality"
                    }, 
                    "doc": "default quality for the base deletions covariate", 
                    "id": "#GATK-BaseRecalibrator.cwl/deletions_default_quality"
                }, 
                {
                    "type": [
                        "null", 
                        "int"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--indels_context_size"
                    }, 
                    "doc": "Size of the k-mer context to be used for base insertions and deletions", 
                    "id": "#GATK-BaseRecalibrator.cwl/indels_context_size"
                }, 
                {
                    "type": "File", 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "-I"
                    }, 
                    "secondaryFiles": [
                        "^.bai"
                    ], 
                    "doc": "bam file produced after indelRealigner", 
                    "id": "#GATK-BaseRecalibrator.cwl/inputBam_BaseRecalibrator"
                }, 
                {
                    "type": [
                        "null", 
                        "int"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--insertions_default_quality"
                    }, 
                    "doc": "default quality for the base insertions covariate", 
                    "id": "#GATK-BaseRecalibrator.cwl/insertions_default_quality"
                }, 
                {
                    "type": [
                        "null", 
                        {
                            "type": "array", 
                            "items": "string", 
                            "inputBinding": {
                                "prefix": "--intervals"
                            }
                        }
                    ], 
                    "inputBinding": {
                        "position": 2
                    }, 
                    "doc": "One or more genomic intervals over which to operate", 
                    "id": "#GATK-BaseRecalibrator.cwl/intervals"
                }, 
                {
                    "type": "string", 
                    "default": "-Xmx4g", 
                    "inputBinding": {
                        "position": 0
                    }, 
                    "id": "#GATK-BaseRecalibrator.cwl/java_arg"
                }, 
                {
                    "type": [
                        "null", 
                        {
                            "type": "array", 
                            "items": "File", 
                            "inputBinding": {
                                "prefix": "--knownSites"
                            }
                        }
                    ], 
                    "secondaryFiles": [
                        ".idx"
                    ], 
                    "inputBinding": {
                        "position": 2
                    }, 
                    "doc": "Any number of VCF files representing known SNPs and/or indels. Could be e.g. dbSNP and/or official 1000 Genomes indel calls. SNPs in these files will be ignored unless the --mismatchFraction argument is used. optional parameter.", 
                    "id": "#GATK-BaseRecalibrator.cwl/knownSites"
                }, 
                {
                    "type": [
                        "null", 
                        "boolean"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--list"
                    }, 
                    "doc": "List the available covariates and exit", 
                    "id": "#GATK-BaseRecalibrator.cwl/list"
                }, 
                {
                    "type": [
                        "null", 
                        "boolean"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--lowMemoryMode"
                    }, 
                    "doc": "Reduce memory usage in multi-threaded code at the expense of threading efficiency", 
                    "id": "#GATK-BaseRecalibrator.cwl/lowMemoryMode"
                }, 
                {
                    "type": [
                        "null", 
                        "int"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--low_quality_tail"
                    }, 
                    "doc": "minimum quality for the bases in the tail of the reads to be considered", 
                    "id": "#GATK-BaseRecalibrator.cwl/low_quality_tail"
                }, 
                {
                    "type": [
                        "null", 
                        "int"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--maximum_cycle_value"
                    }, 
                    "doc": "The maximum cycle value permitted for the Cycle covariate", 
                    "id": "#GATK-BaseRecalibrator.cwl/maximum_cycle_value"
                }, 
                {
                    "type": [
                        "null", 
                        "int"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--mismatches_context_size"
                    }, 
                    "doc": "Size of the k-mer context to be used for base mismatches", 
                    "id": "#GATK-BaseRecalibrator.cwl/mismatches_context_size"
                }, 
                {
                    "type": [
                        "null", 
                        "int"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--mismatches_default_quality"
                    }, 
                    "doc": "default quality for the base mismatches covariate", 
                    "id": "#GATK-BaseRecalibrator.cwl/mismatches_default_quality"
                }, 
                {
                    "type": [
                        "null", 
                        "boolean"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--no_standard_covs"
                    }, 
                    "doc": "Do not use the standard set of covariates, but rather just the ones listed using the -cov argument", 
                    "id": "#GATK-BaseRecalibrator.cwl/no_standard_covs"
                }, 
                {
                    "type": [
                        "null", 
                        "File"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--out"
                    }, 
                    "doc": "The output recalibration table file to create", 
                    "id": "#GATK-BaseRecalibrator.cwl/out"
                }, 
                {
                    "type": "string", 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "-o"
                    }, 
                    "doc": "name of the output file from baseRecalibrator", 
                    "id": "#GATK-BaseRecalibrator.cwl/outputfile_BaseRecalibrator"
                }, 
                {
                    "type": [
                        "null", 
                        "boolean"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--quantizing_levels"
                    }, 
                    "doc": "Sort the rows in the tables of reports. Whether GATK report tables should have rows in sorted order, starting from leftmost column", 
                    "id": "#GATK-BaseRecalibrator.cwl/quantizing_levels"
                }, 
                {
                    "type": "File", 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "-R"
                    }, 
                    "secondaryFiles": [
                        ".amb", 
                        ".ann", 
                        ".bwt", 
                        ".pac", 
                        ".sa", 
                        ".fai", 
                        "^.dict"
                    ], 
                    "id": "#GATK-BaseRecalibrator.cwl/reference"
                }, 
                {
                    "type": [
                        "null", 
                        "boolean"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--run_without_dbsnp_potentially_ruining_quality"
                    }, 
                    "doc": "If specified, allows the recalibrator to be used without a dbsnp rod. Very unsafe and for expert users only.", 
                    "id": "#GATK-BaseRecalibrator.cwl/run_without_dbsnp_potentially_ruining_quality"
                }, 
                {
                    "type": [
                        "null", 
                        "string"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--solid_nocall_strategy"
                    }, 
                    "doc": "Defines the behavior of the recalibrator when it encounters no calls in the color space. Options = THROW_EXCEPTION, LEAVE_READ_UNRECALIBRATED, or PURGE_READ", 
                    "id": "#GATK-BaseRecalibrator.cwl/solid_nocall_strategy"
                }, 
                {
                    "type": [
                        "null", 
                        "string"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--solid_recal_mode"
                    }, 
                    "doc": "How should we recalibrate solid bases in which the reference was inserted? Options = DO_NOTHING, SET_Q_ZERO, SET_Q_ZERO_BASE_N, or REMOVE_REF_BIAS", 
                    "id": "#GATK-BaseRecalibrator.cwl/solid_recal_mode"
                }, 
                {
                    "type": [
                        "null", 
                        "boolean"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--sort_by_all_columns"
                    }, 
                    "doc": "Sort the rows in the tables of reports. Whether GATK report tables should have rows in sorted order, starting from leftmost column", 
                    "id": "#GATK-BaseRecalibrator.cwl/sort_by_all_columns"
                }
            ], 
            "outputs": [
                {
                    "type": "File", 
                    "outputBinding": {
                        "glob": "$(inputs.outputfile_BaseRecalibrator)"
                    }, 
                    "id": "#GATK-BaseRecalibrator.cwl/output_baseRecalibrator"
                }
            ], 
            "arguments": [
                {
                    "valueFrom": "$(runtime.tmpdir)", 
                    "position": 0, 
                    "separate": false, 
                    "prefix": "-Djava.io.tmpdir="
                }, 
                {
                    "valueFrom": "BaseRecalibrator", 
                    "position": 2, 
                    "prefix": "-T"
                }
            ], 
            "baseCommand": [
                "java"
            ], 
            "doc": "GATK-BaseRecalibrator.cwl is developed for CWL consortium\nIt generate base recalibration table to compensate for systematic errors in basecalling confidences\n  Usage: java -jar GenomeAnalysisTK.jar -T BaseRecalibrator -R reference.fasta -I my_reads.bam -knownSites latest_dbsnp.vcf -o recal_data.table.\n", 
            "id": "#GATK-BaseRecalibrator.cwl"
        }, 
        {
            "class": "CommandLineTool", 
            "requirements": [
                {
                    "$import": "#envvar-global.yml"
                }, 
                {
                    "$import": "#GATK-docker.yml"
                }
            ], 
            "inputs": [
                {
                    "type": "File", 
                    "inputBinding": {
                        "position": 1, 
                        "prefix": "-jar"
                    }, 
                    "id": "#GATK-GenotypeGVCFs.cwl/GATKJar"
                }, 
                {
                    "type": [
                        "null", 
                        "boolean"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--annotateNDA"
                    }, 
                    "doc": "If provided, we will annotate records with the number of alternate alleles that were discovered (but not necessarily genotyped) at a given site", 
                    "id": "#GATK-GenotypeGVCFs.cwl/annotateNDA"
                }, 
                {
                    "type": [
                        "null", 
                        {
                            "type": "array", 
                            "items": "string"
                        }
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--annotation"
                    }, 
                    "doc": "One or more specific annotations to apply to variant calls", 
                    "id": "#GATK-GenotypeGVCFs.cwl/annotation"
                }, 
                {
                    "type": [
                        "null", 
                        "File"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--dbsnp"
                    }, 
                    "doc": "latest_dbsnp.vcf set of known indels", 
                    "id": "#GATK-GenotypeGVCFs.cwl/dbsnp"
                }, 
                {
                    "type": [
                        "null", 
                        {
                            "type": "array", 
                            "items": "string"
                        }
                    ], 
                    "inputBinding": {
                        "position": 2
                    }, 
                    "doc": "Input prior for calls", 
                    "id": "#GATK-GenotypeGVCFs.cwl/group"
                }, 
                {
                    "type": [
                        "null", 
                        "double"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--heterozygosity"
                    }, 
                    "doc": "Heterozygosity for indel calling", 
                    "id": "#GATK-GenotypeGVCFs.cwl/heterozygosity"
                }, 
                {
                    "type": [
                        "null", 
                        "double"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--heterozygosity_stdev"
                    }, 
                    "doc": "Heterozygosity for indel calling", 
                    "id": "#GATK-GenotypeGVCFs.cwl/heterozygosity_stdev"
                }, 
                {
                    "type": [
                        "null", 
                        "boolean"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--includeNonVariantSites"
                    }, 
                    "doc": "Include loci found to be non-variant after genotyping", 
                    "id": "#GATK-GenotypeGVCFs.cwl/includeNonVariantSites"
                }, 
                {
                    "type": [
                        "null", 
                        "double"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--indel_heterozygosity"
                    }, 
                    "doc": "Heterozygosity for indel calling", 
                    "id": "#GATK-GenotypeGVCFs.cwl/indel_heterozygosity"
                }, 
                {
                    "type": [
                        "null", 
                        {
                            "type": "array", 
                            "items": "double"
                        }
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--input_prior"
                    }, 
                    "doc": "Input prior for calls", 
                    "id": "#GATK-GenotypeGVCFs.cwl/input_prior"
                }, 
                {
                    "type": [
                        "null", 
                        {
                            "type": "array", 
                            "items": "string"
                        }
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--intervals"
                    }, 
                    "doc": "One or more genomic intervals over which to operate", 
                    "id": "#GATK-GenotypeGVCFs.cwl/intervals"
                }, 
                {
                    "type": "string", 
                    "default": "-Xmx4g", 
                    "inputBinding": {
                        "position": 0
                    }, 
                    "id": "#GATK-GenotypeGVCFs.cwl/java_arg"
                }, 
                {
                    "type": [
                        "null", 
                        "int"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--max_alternate_alleles"
                    }, 
                    "doc": "Maximum number of alternate alleles to genotype", 
                    "id": "#GATK-GenotypeGVCFs.cwl/max_alternate_alleles"
                }, 
                {
                    "type": [
                        "null", 
                        "int"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--max_genotype_count"
                    }, 
                    "doc": "Maximum number of genotypes to consider at any site", 
                    "id": "#GATK-GenotypeGVCFs.cwl/max_genotype_count"
                }, 
                {
                    "type": [
                        "null", 
                        "int"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--max_num_PL_values"
                    }, 
                    "doc": "Maximum number of PL values to output", 
                    "id": "#GATK-GenotypeGVCFs.cwl/max_num_PL_values"
                }, 
                {
                    "type": [
                        "null", 
                        "string"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "-o"
                    }, 
                    "doc": "name of the output file from GenotypeGVCFs", 
                    "id": "#GATK-GenotypeGVCFs.cwl/outputfile_GenotypeGVCFs"
                }, 
                {
                    "type": "File", 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "-R"
                    }, 
                    "secondaryFiles": [
                        ".amb", 
                        ".ann", 
                        ".bwt", 
                        ".pac", 
                        ".sa", 
                        ".fai", 
                        "^.dict"
                    ], 
                    "doc": "Reference genome assembly, indexed", 
                    "id": "#GATK-GenotypeGVCFs.cwl/reference"
                }, 
                {
                    "type": [
                        "null", 
                        "int"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--sample_ploidy"
                    }, 
                    "doc": "Use additional trigger on variants found in an external alleles file", 
                    "id": "#GATK-GenotypeGVCFs.cwl/sample_ploidy"
                }, 
                {
                    "type": [
                        "null", 
                        "double"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--standard_min_confidence_threshold_for_calling"
                    }, 
                    "doc": "The minimum phred-scaled confidence threshold at which variants should be called", 
                    "id": "#GATK-GenotypeGVCFs.cwl/stand_call_conf"
                }, 
                {
                    "type": [
                        "null", 
                        "int"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "-nt"
                    }, 
                    "doc": "Number of data threads to allocate to this analysis", 
                    "id": "#GATK-GenotypeGVCFs.cwl/threads"
                }, 
                {
                    "type": [
                        "null", 
                        "boolean"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--useNewAFCalculator"
                    }, 
                    "doc": "Use new AF model instead of the so-called exact model", 
                    "id": "#GATK-GenotypeGVCFs.cwl/useNewAFCalculator"
                }, 
                {
                    "type": {
                        "type": "array", 
                        "items": "File", 
                        "inputBinding": {
                            "prefix": "-V"
                        }
                    }, 
                    "inputBinding": {
                        "position": 2
                    }, 
                    "doc": "One or more input gVCF files", 
                    "id": "#GATK-GenotypeGVCFs.cwl/variants"
                }
            ], 
            "outputs": [
                {
                    "type": "File", 
                    "outputBinding": {
                        "glob": "$(inputs.outputfile_GenotypeGVCFs)"
                    }, 
                    "secondaryFiles": [
                        ".idx"
                    ], 
                    "id": "#GATK-GenotypeGVCFs.cwl/output_GenotypeGVCFs"
                }
            ], 
            "arguments": [
                {
                    "valueFrom": "$(runtime.tmpdir)", 
                    "position": 0, 
                    "separate": false, 
                    "prefix": "-Djava.io.tmpdir="
                }, 
                {
                    "valueFrom": "GenotypeGVCFs", 
                    "position": 2, 
                    "prefix": "-T"
                }
            ], 
            "baseCommand": [
                "java"
            ], 
            "doc": "GATK-GenotypeGVCFs.cwl is developed for CWL consortium\nPerform joint genotyping on gVCF files produced by HaplotypeCaller\n", 
            "id": "#GATK-GenotypeGVCFs.cwl"
        }, 
        {
            "class": "CommandLineTool", 
            "requirements": [
                {
                    "$import": "#envvar-global.yml"
                }, 
                {
                    "$import": "#GATK-docker.yml"
                }
            ], 
            "inputs": [
                {
                    "type": [
                        "null", 
                        "int"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--indelSizeToEliminateInRefModel"
                    }, 
                    "doc": "The size of an indel to check for in the reference model", 
                    "id": "#GATK-HaplotypeCaller.cwl/ERCIS"
                }, 
                {
                    "type": "File", 
                    "inputBinding": {
                        "position": 1, 
                        "prefix": "-jar"
                    }, 
                    "id": "#GATK-HaplotypeCaller.cwl/GATKJar"
                }, 
                {
                    "type": [
                        "null", 
                        {
                            "type": "array", 
                            "items": "int"
                        }
                    ], 
                    "inputBinding": {
                        "position": 2
                    }, 
                    "doc": "Input prior for calls", 
                    "id": "#GATK-HaplotypeCaller.cwl/GVCFGQBands"
                }, 
                {
                    "type": [
                        "null", 
                        "double"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--activeProbabilityThreshold"
                    }, 
                    "doc": "Threshold for the probability of a profile state being active.", 
                    "id": "#GATK-HaplotypeCaller.cwl/activeProbabilityThreshold"
                }, 
                {
                    "type": [
                        "null", 
                        "int"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--activeRegionExtension"
                    }, 
                    "doc": "The active region extension; if not provided defaults to Walker annotated default", 
                    "id": "#GATK-HaplotypeCaller.cwl/activeRegionExtension"
                }, 
                {
                    "type": [
                        "null", 
                        "int"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--activeRegionMaxSize"
                    }, 
                    "doc": "The active region maximum size; if not provided defaults to Walker annotated default", 
                    "id": "#GATK-HaplotypeCaller.cwl/activeRegionMaxSize"
                }, 
                {
                    "type": [
                        "null", 
                        "File"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--activeRegionOut"
                    }, 
                    "doc": "Output the active region to this IGV formatted file", 
                    "id": "#GATK-HaplotypeCaller.cwl/activeRegionOut"
                }, 
                {
                    "type": [
                        "null", 
                        "File"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--activityProfileOut"
                    }, 
                    "doc": "Output the raw activity profile results in IGV format", 
                    "id": "#GATK-HaplotypeCaller.cwl/activityProfileOut"
                }, 
                {
                    "type": [
                        "null", 
                        "boolean"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--allSitePLs"
                    }, 
                    "doc": "Annotate all sites with PLs", 
                    "id": "#GATK-HaplotypeCaller.cwl/allSitePLs"
                }, 
                {
                    "type": [
                        "null", 
                        {
                            "type": "array", 
                            "items": "string"
                        }
                    ], 
                    "inputBinding": {
                        "position": 2
                    }, 
                    "doc": "The set of alleles at which to genotype when --genotyping_mode is GENOTYPE_GIVEN_ALLELES", 
                    "id": "#GATK-HaplotypeCaller.cwl/alleles"
                }, 
                {
                    "type": [
                        "null", 
                        "boolean"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--allowNonUniqueKmersInRef"
                    }, 
                    "doc": "Allow graphs that have non-unique kmers in the reference", 
                    "id": "#GATK-HaplotypeCaller.cwl/allowNonUniqueKmersInRef"
                }, 
                {
                    "type": [
                        "null", 
                        "boolean"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--annotateNDA"
                    }, 
                    "doc": "If provided, we will annotate records with the number of alternate alleles that were discovered (but not necessarily genotyped) at a given site", 
                    "id": "#GATK-HaplotypeCaller.cwl/annotateNDA"
                }, 
                {
                    "type": [
                        "null", 
                        {
                            "type": "array", 
                            "items": "string"
                        }
                    ], 
                    "inputBinding": {
                        "position": 2
                    }, 
                    "doc": "One or more specific annotations to apply to variant calls", 
                    "id": "#GATK-HaplotypeCaller.cwl/annotation"
                }, 
                {
                    "type": [
                        "null", 
                        "File"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--bamOutput"
                    }, 
                    "doc": "File to which assembled haplotypes should be written", 
                    "id": "#GATK-HaplotypeCaller.cwl/bamOutput"
                }, 
                {
                    "type": [
                        "null", 
                        "string"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--bamWriterType"
                    }, 
                    "doc": "Which haplotypes should be written to the BAM.", 
                    "id": "#GATK-HaplotypeCaller.cwl/bamWriterType"
                }, 
                {
                    "type": [
                        "null", 
                        "double"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--consensus"
                    }, 
                    "doc": "The sigma of the band pass filter Gaussian kernel; if not provided defaults to Walker annotated default", 
                    "id": "#GATK-HaplotypeCaller.cwl/bandPassSigma"
                }, 
                {
                    "type": [
                        "null", 
                        {
                            "type": "array", 
                            "items": "string"
                        }
                    ], 
                    "inputBinding": {
                        "position": 2
                    }, 
                    "doc": "comp binds reference ordered data. This argument supports ROD files of the following types BCF2, VCF, VCF3", 
                    "id": "#GATK-HaplotypeCaller.cwl/comp"
                }, 
                {
                    "type": [
                        "null", 
                        "boolean"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--consensus"
                    }, 
                    "doc": "Print out very verbose debug information about each triggering active region", 
                    "id": "#GATK-HaplotypeCaller.cwl/consensus"
                }, 
                {
                    "type": [
                        "null", 
                        "File"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--contamination_fraction_to_filter"
                    }, 
                    "doc": "Tab-separated File containing fraction of contamination in sequencing data (per sample) to aggressively remove. Format should be \"\" (Contamination is double) per line; No header.", 
                    "id": "#GATK-HaplotypeCaller.cwl/contamination"
                }, 
                {
                    "type": [
                        "null", 
                        "File"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--dbsnp"
                    }, 
                    "doc": "latest_dbsnp.vcf set of known indels", 
                    "id": "#GATK-HaplotypeCaller.cwl/dbsnp"
                }, 
                {
                    "type": [
                        "null", 
                        "boolean"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--debug"
                    }, 
                    "doc": "Print out very verbose debug information about each triggering active region", 
                    "id": "#GATK-HaplotypeCaller.cwl/debug"
                }, 
                {
                    "type": [
                        "null", 
                        "boolean"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--disableOptimizations"
                    }, 
                    "doc": "Dont skip calculations in ActiveRegions with no variants", 
                    "id": "#GATK-HaplotypeCaller.cwl/disableOptimizations"
                }, 
                {
                    "type": [
                        "null", 
                        "boolean"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--doNotRunPhysicalPhasing"
                    }, 
                    "doc": "As of GATK 3.3, HaplotypeCaller outputs physical (read-based) information (see version 3.3 release notes and documentation for details). This argument disables that behavior.", 
                    "id": "#GATK-HaplotypeCaller.cwl/doNotRunPhysicalPhasing"
                }, 
                {
                    "type": [
                        "null", 
                        "boolean"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--dontIncreaseKmerSizesForCycles"
                    }, 
                    "doc": "Disable iterating over kmer sizes when graph cycles are detected", 
                    "id": "#GATK-HaplotypeCaller.cwl/dontIncreaseKmerSizesForCycles"
                }, 
                {
                    "type": [
                        "null", 
                        "boolean"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--dontTrimActiveRegions"
                    }, 
                    "doc": "If specified, we will not trim down the active region from the full region (active + extension) to just the active interval for genotyping", 
                    "id": "#GATK-HaplotypeCaller.cwl/dontTrimActiveRegions"
                }, 
                {
                    "type": [
                        "null", 
                        "string"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--emitRefConfidence"
                    }, 
                    "doc": "Mode for emitting reference confidence scores", 
                    "id": "#GATK-HaplotypeCaller.cwl/emitRefConfidence"
                }, 
                {
                    "type": [
                        "null", 
                        {
                            "type": "array", 
                            "items": "string"
                        }
                    ], 
                    "inputBinding": {
                        "position": 2
                    }, 
                    "doc": "One or more specific annotations to exclude", 
                    "id": "#GATK-HaplotypeCaller.cwl/excludeAnnotation"
                }, 
                {
                    "type": [
                        "null", 
                        "boolean"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--forceActive"
                    }, 
                    "doc": "If provided, all bases will be tagged as active", 
                    "id": "#GATK-HaplotypeCaller.cwl/forceActive"
                }, 
                {
                    "type": [
                        "null", 
                        "int"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--gcpHMM"
                    }, 
                    "doc": "Flat gap continuation penalty for use in the Pair HMM", 
                    "id": "#GATK-HaplotypeCaller.cwl/gcpHMM"
                }, 
                {
                    "type": [
                        "null", 
                        "string"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--genotyping_mode"
                    }, 
                    "doc": "The --genotyping_mode argument is an enumerated type (GenotypingOutputMode), which can have one of the following values", 
                    "id": "#GATK-HaplotypeCaller.cwl/genotyping_mode"
                }, 
                {
                    "type": [
                        "null", 
                        "int"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--phredScaledGlobalReadMismappingRate"
                    }, 
                    "doc": "The global assumed mismapping rate for reads", 
                    "id": "#GATK-HaplotypeCaller.cwl/globalMAPQ"
                }, 
                {
                    "type": [
                        "null", 
                        "File"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--graphOutput"
                    }, 
                    "doc": "Write debug assembly graph information to this file", 
                    "id": "#GATK-HaplotypeCaller.cwl/graphOutput"
                }, 
                {
                    "type": [
                        "null", 
                        {
                            "type": "array", 
                            "items": "string"
                        }
                    ], 
                    "inputBinding": {
                        "position": 2
                    }, 
                    "doc": "Input prior for calls", 
                    "id": "#GATK-HaplotypeCaller.cwl/group"
                }, 
                {
                    "type": [
                        "null", 
                        "double"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--heterozygosity"
                    }, 
                    "doc": "Heterozygosity for indel calling", 
                    "id": "#GATK-HaplotypeCaller.cwl/heterozygosity"
                }, 
                {
                    "type": [
                        "null", 
                        "double"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--indel_heterozygosity"
                    }, 
                    "doc": "Heterozygosity for indel calling", 
                    "id": "#GATK-HaplotypeCaller.cwl/indel_heterozygosity"
                }, 
                {
                    "type": "File", 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "-I"
                    }, 
                    "secondaryFiles": [
                        "^.bai"
                    ], 
                    "doc": "bam file produced after printReads", 
                    "id": "#GATK-HaplotypeCaller.cwl/inputBam_HaplotypeCaller"
                }, 
                {
                    "type": [
                        "null", 
                        {
                            "type": "array", 
                            "items": "double"
                        }
                    ], 
                    "inputBinding": {
                        "position": 2
                    }, 
                    "doc": "Input prior for calls", 
                    "id": "#GATK-HaplotypeCaller.cwl/input_prior"
                }, 
                {
                    "type": [
                        "null", 
                        {
                            "type": "array", 
                            "items": "string"
                        }
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--intervals"
                    }, 
                    "doc": "One or more genomic intervals over which to operate", 
                    "id": "#GATK-HaplotypeCaller.cwl/intervals"
                }, 
                {
                    "type": "string", 
                    "default": "-Xmx4g", 
                    "inputBinding": {
                        "position": 0
                    }, 
                    "id": "#GATK-HaplotypeCaller.cwl/java_arg"
                }, 
                {
                    "type": [
                        "null", 
                        {
                            "type": "array", 
                            "items": "int"
                        }
                    ], 
                    "inputBinding": {
                        "position": 2
                    }, 
                    "doc": "Kmer size to use in the read threading assembler", 
                    "id": "#GATK-HaplotypeCaller.cwl/kmerSize"
                }, 
                {
                    "type": [
                        "null", 
                        "int"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--maxNumHaplotypesInPopulation"
                    }, 
                    "doc": "Maximum number of haplotypes to consider for your population", 
                    "id": "#GATK-HaplotypeCaller.cwl/maxNumHaplotypesInPopulation"
                }, 
                {
                    "type": [
                        "null", 
                        "int"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--maxReadsInRegionPerSample"
                    }, 
                    "doc": "Maximum reads in an active region", 
                    "id": "#GATK-HaplotypeCaller.cwl/maxReadsInRegionPerSample"
                }, 
                {
                    "type": [
                        "null", 
                        "int"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--max_alternate_alleles"
                    }, 
                    "doc": "Maximum number of alternate alleles to genotype", 
                    "id": "#GATK-HaplotypeCaller.cwl/max_alternate_alleles"
                }, 
                {
                    "type": [
                        "null", 
                        "int"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--minDanglingBranchLength"
                    }, 
                    "doc": "Minimum length of a dangling branch to attempt recovery", 
                    "id": "#GATK-HaplotypeCaller.cwl/minDanglingBranchLength"
                }, 
                {
                    "type": [
                        "null", 
                        "int"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--minPruning"
                    }, 
                    "doc": "Minimum support to not prune paths in the graph", 
                    "id": "#GATK-HaplotypeCaller.cwl/minPruning"
                }, 
                {
                    "type": [
                        "null", 
                        "int"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--minReadsPerAlignmentStart"
                    }, 
                    "doc": "Minimum number of reads sharing the same alignment start for each genomic location in an active region", 
                    "id": "#GATK-HaplotypeCaller.cwl/minReadsPerAlignmentStart"
                }, 
                {
                    "type": [
                        "null", 
                        "int"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--min_base_quality_score"
                    }, 
                    "doc": "Minimum base quality required to consider a base for calling", 
                    "id": "#GATK-HaplotypeCaller.cwl/min_base_quality_score"
                }, 
                {
                    "type": [
                        "null", 
                        "int"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--numPruningSamples"
                    }, 
                    "doc": "Number of samples that must pass the minPruning threshold", 
                    "id": "#GATK-HaplotypeCaller.cwl/numPruningSamples"
                }, 
                {
                    "type": [
                        "null", 
                        "string"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--output_mode"
                    }, 
                    "doc": "The PCR indel model to use", 
                    "id": "#GATK-HaplotypeCaller.cwl/output_mode"
                }, 
                {
                    "type": [
                        "null", 
                        "string"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "-o"
                    }, 
                    "doc": "name of the output file from HaplotypeCaller", 
                    "id": "#GATK-HaplotypeCaller.cwl/outputfile_HaplotypeCaller"
                }, 
                {
                    "type": [
                        "null", 
                        "string"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--pcr_indel_model"
                    }, 
                    "doc": "The PCR indel model to use", 
                    "id": "#GATK-HaplotypeCaller.cwl/pcr_indel_model"
                }, 
                {
                    "type": "File", 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "-R"
                    }, 
                    "secondaryFiles": [
                        ".amb", 
                        ".ann", 
                        ".bwt", 
                        ".pac", 
                        ".sa", 
                        ".fai", 
                        "^.dict"
                    ], 
                    "id": "#GATK-HaplotypeCaller.cwl/reference"
                }, 
                {
                    "type": [
                        "null", 
                        "string"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--sample_name"
                    }, 
                    "doc": "Use additional trigger on variants found in an external alleles file", 
                    "id": "#GATK-HaplotypeCaller.cwl/sample_name"
                }, 
                {
                    "type": [
                        "null", 
                        "int"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--sample_ploidy"
                    }, 
                    "doc": "Use additional trigger on variants found in an external alleles file", 
                    "id": "#GATK-HaplotypeCaller.cwl/sample_ploidy"
                }, 
                {
                    "type": [
                        "null", 
                        "double"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--standard_min_confidence_threshold_for_calling"
                    }, 
                    "doc": "The minimum phred-scaled confidence threshold at which variants should be called", 
                    "id": "#GATK-HaplotypeCaller.cwl/stand_call_conf"
                }, 
                {
                    "type": [
                        "null", 
                        "double"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--standard_min_confidence_threshold_for_emitting"
                    }, 
                    "doc": "The minimum phred-scaled confidence threshold at which variants should be emitted (and filtered with LowQual if less than the calling threshold)", 
                    "id": "#GATK-HaplotypeCaller.cwl/stand_emit_conf"
                }, 
                {
                    "type": [
                        "null", 
                        "boolean"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--useAllelesTrigger"
                    }, 
                    "doc": "Use additional trigger on variants found in an external alleles file", 
                    "id": "#GATK-HaplotypeCaller.cwl/useAllelesTrigger"
                }, 
                {
                    "type": [
                        "null", 
                        "boolean"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--useFilteredReadsForAnnotations"
                    }, 
                    "doc": "Use the contamination-filtered read maps for the purposes of annotating variants", 
                    "id": "#GATK-HaplotypeCaller.cwl/useFilteredReadsForAnnotations"
                }, 
                {
                    "type": [
                        "null", 
                        "int"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--variant_index_parameter"
                    }, 
                    "doc": "Index parameter, needed by emitRefConfidence GVCF if output extension not .g.vcf", 
                    "id": "#GATK-HaplotypeCaller.cwl/variant_index_parameter"
                }, 
                {
                    "type": [
                        "null", 
                        "string"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--variant_index_type"
                    }, 
                    "doc": "Index type, needed by emitRefConfidence GVCF if output extension not .g.vcf", 
                    "id": "#GATK-HaplotypeCaller.cwl/variant_index_type"
                }
            ], 
            "outputs": [
                {
                    "type": "File", 
                    "outputBinding": {
                        "glob": "$(inputs.outputfile_HaplotypeCaller)"
                    }, 
                    "secondaryFiles": [
                        ".idx"
                    ], 
                    "id": "#GATK-HaplotypeCaller.cwl/output_HaplotypeCaller"
                }
            ], 
            "arguments": [
                {
                    "valueFrom": "$(runtime.tmpdir)", 
                    "position": 0, 
                    "separate": false, 
                    "prefix": "-Djava.io.tmpdir="
                }, 
                {
                    "valueFrom": "HaplotypeCaller", 
                    "position": 2, 
                    "prefix": "-T"
                }
            ], 
            "baseCommand": [
                "java"
            ], 
            "doc": "GATK-RealignTargetCreator.cwl is developed for CWL consortium\nCall germline SNPs and indels via local re-assembly of haplotypes\n", 
            "id": "#GATK-HaplotypeCaller.cwl"
        }, 
        {
            "class": "CommandLineTool", 
            "requirements": [
                {
                    "$import": "#envvar-global.yml"
                }, 
                {
                    "$import": "#GATK-docker.yml"
                }
            ], 
            "inputs": [
                {
                    "type": "File", 
                    "inputBinding": {
                        "position": 1, 
                        "prefix": "-jar"
                    }, 
                    "id": "#GATK-PrintReads.cwl/GATKJar"
                }, 
                {
                    "type": "File", 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "-I"
                    }, 
                    "secondaryFiles": [
                        "^.bai"
                    ], 
                    "doc": "bam file produced after indelRealigner", 
                    "id": "#GATK-PrintReads.cwl/inputBam_printReads"
                }, 
                {
                    "type": "File", 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "-BQSR"
                    }, 
                    "doc": "the recalibration table produced by BaseRecalibration", 
                    "id": "#GATK-PrintReads.cwl/input_baseRecalibrator"
                }, 
                {
                    "type": [
                        "null", 
                        {
                            "type": "array", 
                            "items": "string", 
                            "inputBinding": {
                                "prefix": "--intervals"
                            }
                        }
                    ], 
                    "inputBinding": {
                        "position": 2
                    }, 
                    "doc": "One or more genomic intervals over which to operate", 
                    "id": "#GATK-PrintReads.cwl/intervals"
                }, 
                {
                    "type": "string", 
                    "default": "-Xmx4g", 
                    "inputBinding": {
                        "position": 0
                    }, 
                    "id": "#GATK-PrintReads.cwl/java_arg"
                }, 
                {
                    "type": [
                        "null", 
                        "string"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--number"
                    }, 
                    "doc": "Exclude all reads with this platform from the output", 
                    "id": "#GATK-PrintReads.cwl/number"
                }, 
                {
                    "type": [
                        "null", 
                        "string"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "-o"
                    }, 
                    "doc": "name of the output file from indelRealigner", 
                    "id": "#GATK-PrintReads.cwl/outputfile_printReads"
                }, 
                {
                    "type": [
                        "null", 
                        "string"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--platform"
                    }, 
                    "doc": "Exclude all reads with this platform from the output", 
                    "id": "#GATK-PrintReads.cwl/platform"
                }, 
                {
                    "type": [
                        "null", 
                        "string"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--readGroup"
                    }, 
                    "doc": "Exclude all reads with this read group from the output", 
                    "id": "#GATK-PrintReads.cwl/readGroup"
                }, 
                {
                    "type": "File", 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "-R"
                    }, 
                    "secondaryFiles": [
                        ".amb", 
                        ".ann", 
                        ".bwt", 
                        ".pac", 
                        ".sa", 
                        ".fai", 
                        "^.dict"
                    ], 
                    "id": "#GATK-PrintReads.cwl/reference"
                }, 
                {
                    "type": [
                        "null", 
                        {
                            "type": "array", 
                            "items": "File"
                        }
                    ], 
                    "inputBinding": {
                        "position": 2
                    }, 
                    "id": "#GATK-PrintReads.cwl/sample_file"
                }, 
                {
                    "type": [
                        "null", 
                        {
                            "type": "array", 
                            "items": "string"
                        }
                    ], 
                    "inputBinding": {
                        "position": 2
                    }, 
                    "doc": "Sample name to be included in the analysis. Can be specified multiple times.", 
                    "id": "#GATK-PrintReads.cwl/sample_name"
                }, 
                {
                    "type": [
                        "null", 
                        "boolean"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--simplify"
                    }, 
                    "doc": "Erase all extra attributes in the read but keep the read group information", 
                    "id": "#GATK-PrintReads.cwl/simplify"
                }
            ], 
            "outputs": [
                {
                    "type": "File", 
                    "outputBinding": {
                        "glob": "$(inputs.outputfile_printReads)"
                    }, 
                    "secondaryFiles": [
                        "^.bai"
                    ], 
                    "id": "#GATK-PrintReads.cwl/output_printReads"
                }
            ], 
            "arguments": [
                {
                    "valueFrom": "$(runtime.tmpdir)", 
                    "position": 0, 
                    "separate": false, 
                    "prefix": "-Djava.io.tmpdir="
                }, 
                {
                    "valueFrom": "PrintReads", 
                    "position": 2, 
                    "prefix": "-T"
                }
            ], 
            "baseCommand": [
                "java"
            ], 
            "doc": "GATK-RealignTargetCreator.cwl is developed for CWL consortium\nPrints all reads that have a mapping quality above zero\n  Usage: java -Xmx4g -jar GenomeAnalysisTK.jar -T PrintReads -R reference.fasta -I input1.bam -I input2.bam -o output.bam --read_filter MappingQualityZero\n", 
            "id": "#GATK-PrintReads.cwl"
        }, 
        {
            "class": "CommandLineTool", 
            "doc": "GATK-VariantsRecalibrator.cwl is developed for CWL consortium\n\nUsage:\n```\njava -Xmx8G \\\n      -jar gatk.jar\n      -T VariantRecalibrator \\\n      -R [reference_fasta] \\\n      -recalFile    $tmpDir/out.recal \\\n      -tranchesFile $tmpDir/out.tranches \\\n      -rscriptFile  $tmpDir/out.R \\\n      -nt 4 \\\n      -an MQRankSum -an ReadPosRankSum -an DP -an FS -an QD \\\n      -mode SNP \\\n      -resource:hapmap,known=false,training=true,truth=true,prior=15.0 [hapmap_vcf] \\\n      -resource:dbsnp,known=true,training=false,truth=false,prior=2.0  [dbsnp_vcf] \\\n      -resource:omni,known=false,training=true,truth=true,prior=12.0   [1komni_vcf] \\\n      -resource:1000G,known=false,training=true,truth=false,prior=10.0 [1ksnp_vcf]\n```\n", 
            "requirements": [
                {
                    "$import": "#envvar-global.yml"
                }, 
                {
                    "$import": "#GATK-docker.yml"
                }
            ], 
            "inputs": [
                {
                    "type": "File", 
                    "inputBinding": {
                        "position": 1, 
                        "prefix": "-jar"
                    }, 
                    "id": "#GATK-VariantRecalibrator-Indels.cwl/GATKJar"
                }, 
                {
                    "type": {
                        "type": "array", 
                        "items": "string", 
                        "inputBinding": {
                            "prefix": "-an"
                        }
                    }, 
                    "inputBinding": {
                        "position": 2
                    }, 
                    "doc": "The names of the annotations which should used for calculations", 
                    "id": "#GATK-VariantRecalibrator-Indels.cwl/annotations"
                }, 
                {
                    "type": [
                        "null", 
                        {
                            "type": "array", 
                            "items": "string"
                        }
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--intervals"
                    }, 
                    "doc": "One or more genomic intervals over which to operate", 
                    "id": "#GATK-VariantRecalibrator-Indels.cwl/intervals"
                }, 
                {
                    "type": "string", 
                    "default": "-Xmx8g", 
                    "inputBinding": {
                        "position": 0
                    }, 
                    "id": "#GATK-VariantRecalibrator-Indels.cwl/java_arg"
                }, 
                {
                    "type": [
                        "null", 
                        "int"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--maxGaussians"
                    }, 
                    "doc": "Maximum number of different clusters (gaussians) of variants the program is allowed to try to identify.", 
                    "id": "#GATK-VariantRecalibrator-Indels.cwl/max_gaussians"
                }, 
                {
                    "type": "string", 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "-recalFile"
                    }, 
                    "id": "#GATK-VariantRecalibrator-Indels.cwl/outputfile_recal"
                }, 
                {
                    "type": [
                        "null", 
                        "string"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "-rscriptFile"
                    }, 
                    "id": "#GATK-VariantRecalibrator-Indels.cwl/outputfile_rscript"
                }, 
                {
                    "type": "string", 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "-tranchesFile"
                    }, 
                    "id": "#GATK-VariantRecalibrator-Indels.cwl/outputfile_tranches"
                }, 
                {
                    "type": "File", 
                    "secondaryFiles": [
                        ".fai", 
                        "^.dict"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "-R"
                    }, 
                    "doc": "reference genome", 
                    "id": "#GATK-VariantRecalibrator-Indels.cwl/reference"
                }, 
                {
                    "type": "File", 
                    "secondaryFiles": [
                        ".idx"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "-resource:dbsnp,known=true,training=false,truth=false,prior=2.0"
                    }, 
                    "doc": "dbSNP reference data", 
                    "id": "#GATK-VariantRecalibrator-Indels.cwl/resource_dbsnp"
                }, 
                {
                    "type": "File", 
                    "secondaryFiles": [
                        ".idx"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "-resource:mills,known=false,training=true,truth=true,prior=12.0"
                    }, 
                    "doc": "hapmap reference data", 
                    "id": "#GATK-VariantRecalibrator-Indels.cwl/resource_mills"
                }, 
                {
                    "type": [
                        "null", 
                        "int"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "-nt"
                    }, 
                    "doc": "Number of data threads to allocate to this analysis", 
                    "id": "#GATK-VariantRecalibrator-Indels.cwl/threads"
                }, 
                {
                    "type": "File", 
                    "secondaryFiles": [
                        ".idx"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "-input"
                    }, 
                    "doc": "input vcf File raw variant calls from haplotype caller", 
                    "id": "#GATK-VariantRecalibrator-Indels.cwl/variants"
                }
            ], 
            "outputs": [
                {
                    "type": "File", 
                    "outputBinding": {
                        "glob": "$(inputs.outputfile_recal)"
                    }, 
                    "secondaryFiles": [
                        ".pdf"
                    ], 
                    "doc": "the recal File", 
                    "id": "#GATK-VariantRecalibrator-Indels.cwl/recal_File"
                }, 
                {
                    "type": "File", 
                    "outputBinding": {
                        "glob": "$(inputs.outputfile_tranches)"
                    }, 
                    "secondaryFiles": [
                        ".pdf"
                    ], 
                    "doc": "the tranches File", 
                    "id": "#GATK-VariantRecalibrator-Indels.cwl/tranches_File"
                }, 
                {
                    "type": [
                        "null", 
                        "File"
                    ], 
                    "outputBinding": {
                        "glob": "$(inputs.outputfile_rscript)"
                    }, 
                    "secondaryFiles": [
                        ".pdf"
                    ], 
                    "doc": "The output recalibration R script for the plots", 
                    "id": "#GATK-VariantRecalibrator-Indels.cwl/vqsr_rscript"
                }
            ], 
            "arguments": [
                {
                    "valueFrom": "$(runtime.tmpdir)", 
                    "position": 0, 
                    "separate": false, 
                    "prefix": "-Djava.io.tmpdir="
                }, 
                {
                    "valueFrom": "VariantRecalibrator", 
                    "position": 2, 
                    "prefix": "-T"
                }, 
                {
                    "valueFrom": "INDEL", 
                    "position": 2, 
                    "prefix": "-mode"
                }
            ], 
            "baseCommand": [
                "java"
            ], 
            "id": "#GATK-VariantRecalibrator-Indels.cwl"
        }, 
        {
            "class": "CommandLineTool", 
            "doc": "GATK-VariantsRecalibrator.cwl is developed for CWL consortium\n\nUsage:\n```\njava -Xmx8G \\\n      -jar gatk.jar\n      -T VariantRecalibrator \\\n      -R [reference_fasta] \\\n      -recalFile    $tmpDir/out.recal \\\n      -tranchesFile $tmpDir/out.tranches \\\n      -rscriptFile  $tmpDir/out.R \\\n      -nt 4 \\\n      -an MQRankSum -an ReadPosRankSum -an DP -an FS -an QD \\\n      -mode SNP \\\n      -resource:hapmap,known=false,training=true,truth=true,prior=15.0 [hapmap_vcf] \\\n      -resource:dbsnp,known=true,training=false,truth=false,prior=2.0  [dbsnp_vcf] \\\n      -resource:omni,known=false,training=true,truth=true,prior=12.0   [1komni_vcf] \\\n      -resource:1000G,known=false,training=true,truth=false,prior=10.0 [1ksnp_vcf]\n```\n", 
            "requirements": [
                {
                    "$import": "#envvar-global.yml"
                }, 
                {
                    "$import": "#GATK-docker.yml"
                }
            ], 
            "inputs": [
                {
                    "type": "File", 
                    "inputBinding": {
                        "position": 1, 
                        "prefix": "-jar"
                    }, 
                    "id": "#GATK-VariantRecalibrator-SNPs.cwl/GATKJar"
                }, 
                {
                    "type": {
                        "type": "array", 
                        "items": "string", 
                        "inputBinding": {
                            "prefix": "-an"
                        }
                    }, 
                    "inputBinding": {
                        "position": 2
                    }, 
                    "doc": "The names of the annotations which should used for calculations", 
                    "id": "#GATK-VariantRecalibrator-SNPs.cwl/annotations"
                }, 
                {
                    "type": [
                        "null", 
                        {
                            "type": "array", 
                            "items": "string"
                        }
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--intervals"
                    }, 
                    "doc": "One or more genomic intervals over which to operate", 
                    "id": "#GATK-VariantRecalibrator-SNPs.cwl/intervals"
                }, 
                {
                    "type": "string", 
                    "default": "-Xmx8g", 
                    "inputBinding": {
                        "position": 0
                    }, 
                    "id": "#GATK-VariantRecalibrator-SNPs.cwl/java_arg"
                }, 
                {
                    "type": [
                        "null", 
                        "int"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "--maxGaussians"
                    }, 
                    "doc": "Maximum number of different clusters (gaussians) of variants the program is allowed to try to identify.", 
                    "id": "#GATK-VariantRecalibrator-SNPs.cwl/max_gaussians"
                }, 
                {
                    "type": "string", 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "-recalFile"
                    }, 
                    "id": "#GATK-VariantRecalibrator-SNPs.cwl/outputfile_recal"
                }, 
                {
                    "type": [
                        "null", 
                        "string"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "-rscriptFile"
                    }, 
                    "id": "#GATK-VariantRecalibrator-SNPs.cwl/outputfile_rscript"
                }, 
                {
                    "type": "string", 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "-tranchesFile"
                    }, 
                    "id": "#GATK-VariantRecalibrator-SNPs.cwl/outputfile_tranches"
                }, 
                {
                    "type": "File", 
                    "secondaryFiles": [
                        ".fai", 
                        "^.dict"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "-R"
                    }, 
                    "doc": "reference genome", 
                    "id": "#GATK-VariantRecalibrator-SNPs.cwl/reference"
                }, 
                {
                    "type": "File", 
                    "secondaryFiles": [
                        ".idx"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "-resource:1000G,known=false,training=true,truth=false,prior=10.0"
                    }, 
                    "doc": "1000 genome reference data", 
                    "id": "#GATK-VariantRecalibrator-SNPs.cwl/resource_1kg"
                }, 
                {
                    "type": "File", 
                    "secondaryFiles": [
                        ".idx"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "-resource:dbsnp,known=true,training=false,truth=false,prior=2.0"
                    }, 
                    "doc": "dbSNP reference data", 
                    "id": "#GATK-VariantRecalibrator-SNPs.cwl/resource_dbsnp"
                }, 
                {
                    "type": "File", 
                    "secondaryFiles": [
                        ".idx"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "-resource:hapmap,known=false,training=true,truth=true,prior=15.0"
                    }, 
                    "doc": "hapmap reference data", 
                    "id": "#GATK-VariantRecalibrator-SNPs.cwl/resource_hapmap"
                }, 
                {
                    "type": "File", 
                    "secondaryFiles": [
                        ".idx"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "-resource:omni,known=false,training=true,truth=false,prior=12.0"
                    }, 
                    "doc": "omni reference data", 
                    "id": "#GATK-VariantRecalibrator-SNPs.cwl/resource_omni"
                }, 
                {
                    "type": [
                        "null", 
                        "int"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "-nt"
                    }, 
                    "doc": "Number of data threads to allocate to this analysis", 
                    "id": "#GATK-VariantRecalibrator-SNPs.cwl/threads"
                }, 
                {
                    "type": "File", 
                    "secondaryFiles": [
                        ".idx"
                    ], 
                    "inputBinding": {
                        "position": 2, 
                        "prefix": "-input"
                    }, 
                    "doc": "input vcf File raw variant calls from haplotype caller", 
                    "id": "#GATK-VariantRecalibrator-SNPs.cwl/variants"
                }
            ], 
            "outputs": [
                {
                    "type": "File", 
                    "outputBinding": {
                        "glob": "$(inputs.outputfile_recal)"
                    }, 
                    "secondaryFiles": [
                        ".pdf"
                    ], 
                    "doc": "the recal File", 
                    "id": "#GATK-VariantRecalibrator-SNPs.cwl/recal_File"
                }, 
                {
                    "type": "File", 
                    "outputBinding": {
                        "glob": "$(inputs.outputfile_tranches)"
                    }, 
                    "secondaryFiles": [
                        ".pdf"
                    ], 
                    "doc": "the tranches File", 
                    "id": "#GATK-VariantRecalibrator-SNPs.cwl/tranches_File"
                }, 
                {
                    "type": [
                        "null", 
                        "File"
                    ], 
                    "outputBinding": {
                        "glob": "$(inputs.outputfile_rscript)"
                    }, 
                    "secondaryFiles": [
                        ".pdf"
                    ], 
                    "doc": "The output recalibration R script for the plots", 
                    "id": "#GATK-VariantRecalibrator-SNPs.cwl/vqsr_rscript"
                }
            ], 
            "arguments": [
                {
                    "valueFrom": "$(runtime.tmpdir)", 
                    "position": 0, 
                    "separate": false, 
                    "prefix": "-Djava.io.tmpdir="
                }, 
                {
                    "valueFrom": "VariantRecalibrator", 
                    "position": 2, 
                    "prefix": "-T"
                }, 
                {
                    "valueFrom": "SNP", 
                    "position": 2, 
                    "prefix": "-mode"
                }
            ], 
            "baseCommand": [
                "java"
            ], 
            "id": "#GATK-VariantRecalibrator-SNPs.cwl"
        }, 
        {
            "class": "CommandLineTool", 
            "requirements": [
                {
                    "$import": "#envvar-global.yml"
                }, 
                {
                    "class": "DockerRequirement", 
                    "dockerPull": "scidap/bwa:v0.7.12", 
                    "dockerFile": "$import: bwa-Dockerfile\n", 
                    "id": "#bwa-docker.yml", 
                    "name": "#bwa-docker.yml"
                }, 
                {
                    "class": "InlineJavascriptRequirement"
                }
            ], 
            "inputs": [
                {
                    "type": [
                        "null", 
                        {
                            "type": "array", 
                            "items": "int"
                        }
                    ], 
                    "inputBinding": {
                        "position": 1, 
                        "prefix": "-I", 
                        "itemSeparator": ","
                    }, 
                    "id": "#bwa-mem.cwl/min_std_max_min"
                }, 
                {
                    "type": [
                        "null", 
                        "int"
                    ], 
                    "inputBinding": {
                        "position": 1, 
                        "prefix": "-k"
                    }, 
                    "doc": "-k INT        minimum seed length [19]", 
                    "id": "#bwa-mem.cwl/minimum_seed_length"
                }, 
                {
                    "type": "string", 
                    "id": "#bwa-mem.cwl/output_filename"
                }, 
                {
                    "type": [
                        "null", 
                        "string"
                    ], 
                    "inputBinding": {
                        "position": 1, 
                        "prefix": "-R"
                    }, 
                    "doc": "-R STR        read group header line such as '@RG\\tID:foo\\tSM:bar' [null]", 
                    "id": "#bwa-mem.cwl/read_group_header"
                }, 
                {
                    "type": {
                        "type": "array", 
                        "items": "File"
                    }, 
                    "inputBinding": {
                        "position": 3
                    }, 
                    "id": "#bwa-mem.cwl/reads"
                }, 
                {
                    "type": "File", 
                    "inputBinding": {
                        "position": 2
                    }, 
                    "secondaryFiles": [
                        ".amb", 
                        ".ann", 
                        ".bwt", 
                        ".pac", 
                        ".sa"
                    ], 
                    "id": "#bwa-mem.cwl/reference"
                }, 
                {
                    "type": [
                        "null", 
                        "int"
                    ], 
                    "inputBinding": {
                        "position": 1, 
                        "prefix": "-t"
                    }, 
                    "doc": "-t INT        number of threads [1]", 
                    "id": "#bwa-mem.cwl/threads"
                }
            ], 
            "stdout": "$(inputs.output_filename)", 
            "outputs": [
                {
                    "type": "File", 
                    "outputBinding": {
                        "glob": "$(inputs.output_filename)"
                    }, 
                    "id": "#bwa-mem.cwl/output"
                }
            ], 
            "baseCommand": [
                "bwa", 
                "mem"
            ], 
            "doc": "Usage: bwa mem [options] <idxbase> <in1.fq> [in2.fq]\n\nAlgorithm options:\n       -w INT        band width for banded alignment [100]\n       -d INT        off-diagonal X-dropoff [100]\n       -r FLOAT      look for internal seeds inside a seed longer than {-k} * FLOAT [1.5]\n       -y INT        seed occurrence for the 3rd round seeding [20]\n       -c INT        skip seeds with more than INT occurrences [500]\n       -D FLOAT      drop chains shorter than FLOAT fraction of the longest overlapping chain [0.50]\n       -W INT        discard a chain if seeded bases shorter than INT [0]\n       -m INT        perform at most INT rounds of mate rescues for each read [50]\n       -S            skip mate rescue\n       -P            skip pairing; mate rescue performed unless -S also in use\n       -e            discard full-length exact matches\n\nScoring options:\n\n       -A INT        score for a sequence match, which scales options -TdBOELU unless overridden [1]\n       -B INT        penalty for a mismatch [4]\n       -O INT[,INT]  gap open penalties for deletions and insertions [6,6]\n       -E INT[,INT]  gap extension penalty; a gap of size k cost '{-O} + {-E}*k' [1,1]\n       -L INT[,INT]  penalty for 5'- and 3'-end clipping [5,5]\n       -U INT        penalty for an unpaired read pair [17]\n\n       -x STR        read type. Setting -x changes multiple parameters unless overriden [null]\n                     pacbio: -k17 -W40 -r10 -A1 -B1 -O1 -E1 -L0  (PacBio reads to ref)\n                     ont2d: -k14 -W20 -r10 -A1 -B1 -O1 -E1 -L0  (Oxford Nanopore 2D-reads to ref)\n                     intractg: -B9 -O16 -L5  (intra-species contigs to ref)\n\nInput/output options:\n\n       -p            smart pairing (ignoring in2.fq)\n       -R STR        read group header line such as '@RG\\tID:foo\\tSM:bar' [null]\n       -H STR/FILE   insert STR to header if it starts with @; or insert lines in FILE [null]\n       -j            treat ALT contigs as part of the primary assembly (i.e. ignore <idxbase>.alt file)\n\n       -v INT        verbose level: 1=error, 2=warning, 3=message, 4+=debugging [3]\n       -T INT        minimum score to output [30]\n       -h INT[,INT]  if there are <INT hits with score >80% of the max score, output all in XA [5,200]\n       -a            output all alignments for SE or unpaired PE\n       -C            append FASTA/FASTQ comment to SAM output\n       -V            output the reference FASTA header in the XR tag\n       -Y            use soft clipping for supplementary alignments\n       -M            mark shorter split hits as secondary\n\n       -I FLOAT[,FLOAT[,INT[,INT]]]\n                     specify the mean, standard deviation (10% of the mean if absent), max\n                     (4 sigma from the mean if absent) and min of the insert size distribution.\n                     FR orientation only. [inferred]\n\nNote: Please read the man page for detailed description of the command line and options.\n", 
            "id": "#bwa-mem.cwl"
        }, 
        {
            "class": "ExpressionTool", 
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ], 
            "inputs": [
                {
                    "type": {
                        "type": "array", 
                        "items": "File"
                    }, 
                    "id": "#concat-file-arrays.cwl/array1"
                }, 
                {
                    "type": {
                        "type": "array", 
                        "items": "File"
                    }, 
                    "id": "#concat-file-arrays.cwl/array2"
                }
            ], 
            "outputs": [
                {
                    "type": {
                        "type": "array", 
                        "items": "File"
                    }, 
                    "id": "#concat-file-arrays.cwl/output"
                }
            ], 
            "expression": "${\n  var output = inputs.array1.concat(inputs.array2);\n  return { \"output\": output };\n}\n", 
            "id": "#concat-file-arrays.cwl"
        }, 
        {
            "class": "CommandLineTool", 
            "hints": [
                {
                    "class": "DockerRequirement", 
                    "dockerPull": "dukegcb/fastqc"
                }
            ], 
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ], 
            "inputs": [
                {
                    "type": "string", 
                    "default": "fastq", 
                    "inputBinding": {
                        "position": 3, 
                        "prefix": "--format"
                    }, 
                    "id": "#fastqc.cwl/format"
                }, 
                {
                    "type": "File", 
                    "inputBinding": {
                        "position": 4
                    }, 
                    "id": "#fastqc.cwl/input_fastq_file"
                }, 
                {
                    "type": "boolean", 
                    "default": true, 
                    "inputBinding": {
                        "prefix": "--noextract", 
                        "position": 2
                    }, 
                    "id": "#fastqc.cwl/noextract"
                }, 
                {
                    "type": "int", 
                    "default": 1, 
                    "inputBinding": {
                        "position": 5, 
                        "prefix": "--threads"
                    }, 
                    "id": "#fastqc.cwl/threads"
                }
            ], 
            "outputs": [
                {
                    "type": "File", 
                    "outputBinding": {
                        "glob": "*_fastqc.zip"
                    }, 
                    "id": "#fastqc.cwl/output_qc_report"
                }
            ], 
            "baseCommand": "fastqc", 
            "arguments": [
                {
                    "valueFrom": "$('/tmp')", 
                    "prefix": "--dir", 
                    "position": 5
                }, 
                {
                    "valueFrom": "$(runtime.outdir)", 
                    "prefix": "-o", 
                    "position": 5
                }
            ], 
            "id": "#fastqc.cwl"
        }, 
        {
            "class": "ExpressionTool", 
            "label": "Extracts a read group header from the first file name in an array of files", 
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ], 
            "inputs": [
                {
                    "type": [
                        "null", 
                        {
                            "type": "array", 
                            "items": "string"
                        }
                    ], 
                    "default": [
                        "sample", 
                        "barcode", 
                        "lane", 
                        "read", 
                        "part"
                    ], 
                    "id": "#parse-read-group-header.cwl/field_order"
                }, 
                {
                    "type": "string", 
                    "id": "#parse-read-group-header.cwl/library"
                }, 
                {
                    "type": "string", 
                    "id": "#parse-read-group-header.cwl/platform"
                }, 
                {
                    "type": {
                        "type": "array", 
                        "items": "File"
                    }, 
                    "id": "#parse-read-group-header.cwl/reads"
                }, 
                {
                    "type": "string", 
                    "default": "_", 
                    "id": "#parse-read-group-header.cwl/separator"
                }
            ], 
            "outputs": [
                {
                    "type": "string", 
                    "id": "#parse-read-group-header.cwl/read_group_header"
                }
            ], 
            "expression": "${\n  // Returns the part of the filename before the extension\n  function removeExtension(name) {\n    return name.split('.')[0];\n  }\n\n  // Given an array of keys and values, creates an object mapping keys to values\n  function zip(keys, values) {\n    var object = {};\n    for (var i=0;i<keys.length;i++) {\n      object[keys[i]] = values[i]\n    }\n    return object;\n  }\n\n  // Split the string name on the separator\n  function splitFields(name, separator) {\n  \treturn name.split(separator);\n  }\n\n  // Makes a string with a read group header that can be provided to bwa as SAM metadata\n  function makeReadGroupsString(fields) {\n    \tvar readGroups = \"@RG\" +\n    \t  \"\\\\tID:\" + fields['sample'] +\n    \t  \"\\\\tLB:\" + fields['library'] +\n    \t  \"\\\\tPL:\" + fields['platform'] +\n    \t  \"\\\\tPU:\" + fields['sample'] +\n    \t  \"\\\\tSM:\" + fields['sample'];\n      return readGroups;\n  }\n\n  var filename = inputs.reads[0].basename;\n  var base = removeExtension(filename);\n  var components = splitFields(base, inputs.separator);\n  var fields = zip(inputs.field_order, components);\n  fields['library'] = inputs.library;\n  fields['platform'] = inputs.platform;\n  var read_group_header = makeReadGroupsString(fields);\n\n  return {\n    read_group_header: read_group_header\n  };\n}\n", 
            "id": "#parse-read-group-header.cwl"
        }, 
        {
            "class": "CommandLineTool", 
            "requirements": [
                {
                    "class": "DockerRequirement", 
                    "dockerPull": "dukegcb/picard"
                }, 
                {
                    "class": "InlineJavascriptRequirement"
                }
            ], 
            "inputs": [
                {
                    "type": "File", 
                    "doc": "One or more input SAM or BAM files to analyze. Must be coordinate sorted.", 
                    "inputBinding": {
                        "prefix": "INPUT=", 
                        "shellQuote": false
                    }, 
                    "id": "#picard-MarkDuplicates.cwl/input_file"
                }, 
                {
                    "type": [
                        "null", 
                        "string"
                    ], 
                    "doc": "Output metrics filename", 
                    "default": "marked_dup_metrics.txt", 
                    "inputBinding": {
                        "prefix": "METRICS_FILE=", 
                        "shellQuote": false
                    }, 
                    "id": "#picard-MarkDuplicates.cwl/metrics_filename"
                }, 
                {
                    "type": [
                        "null", 
                        "string"
                    ], 
                    "doc": "Output filename", 
                    "default": "marked_duplicates.bam", 
                    "inputBinding": {
                        "prefix": "OUTPUT=", 
                        "shellQuote": false
                    }, 
                    "id": "#picard-MarkDuplicates.cwl/output_filename"
                }, 
                {
                    "type": "boolean", 
                    "doc": "If true do not write duplicates to the output file instead of writing them with appropriate flags set.  (Default true).", 
                    "default": true, 
                    "inputBinding": {
                        "prefix": "REMOVE_DUPLICATES=", 
                        "shellQuote": false
                    }, 
                    "id": "#picard-MarkDuplicates.cwl/remove_duplicates"
                }
            ], 
            "outputs": [
                {
                    "type": "File", 
                    "outputBinding": {
                        "glob": "$(inputs.output_filename)"
                    }, 
                    "secondaryFiles": [
                        "^.bai"
                    ], 
                    "id": "#picard-MarkDuplicates.cwl/output_dedup_bam_file"
                }, 
                {
                    "type": "File", 
                    "outputBinding": {
                        "glob": "$(inputs.metrics_filename)"
                    }, 
                    "id": "#picard-MarkDuplicates.cwl/output_metrics_file"
                }
            ], 
            "baseCommand": [
                "java"
            ], 
            "arguments": [
                {
                    "valueFrom": "/usr/picard/picard.jar", 
                    "position": -1, 
                    "prefix": "-jar"
                }, 
                {
                    "valueFrom": "MarkDuplicates", 
                    "position": 0
                }, 
                {
                    "valueFrom": "CREATE_INDEX=True", 
                    "position": 0
                }
            ], 
            "id": "#picard-MarkDuplicates.cwl"
        }, 
        {
            "class": "CommandLineTool", 
            "requirements": [
                {
                    "class": "DockerRequirement", 
                    "dockerPull": "dukegcb/picard"
                }, 
                {
                    "class": "InlineJavascriptRequirement"
                }
            ], 
            "inputs": [
                {
                    "type": "File", 
                    "doc": "The BAM or SAM file to sort.  Required.", 
                    "inputBinding": {
                        "prefix": "INPUT=", 
                        "shellQuote": false
                    }, 
                    "id": "#picard-SortSam.cwl/input_file"
                }, 
                {
                    "type": [
                        "null", 
                        "string"
                    ], 
                    "doc": "The sorted BAM or SAM output file.", 
                    "default": "sorted.bam", 
                    "inputBinding": {
                        "prefix": "OUTPUT=", 
                        "shellQuote": false
                    }, 
                    "id": "#picard-SortSam.cwl/output_filename"
                }, 
                {
                    "type": "string", 
                    "doc": "Sort order of output file  Required. Possible values: {unsorted, queryname, coordinate, duplicate}", 
                    "default": "coordinate", 
                    "inputBinding": {
                        "prefix": "SORT_ORDER=", 
                        "shellQuote": false
                    }, 
                    "id": "#picard-SortSam.cwl/sort_order"
                }
            ], 
            "outputs": [
                {
                    "type": "File", 
                    "outputBinding": {
                        "glob": "$(inputs.output_filename)"
                    }, 
                    "secondaryFiles": [
                        "^.bai"
                    ], 
                    "id": "#picard-SortSam.cwl/sorted"
                }
            ], 
            "baseCommand": [
                "java"
            ], 
            "arguments": [
                {
                    "valueFrom": "/usr/picard/picard.jar", 
                    "position": -1, 
                    "prefix": "-jar"
                }, 
                {
                    "valueFrom": "SortSam", 
                    "position": 0
                }
            ], 
            "id": "#picard-SortSam.cwl"
        }, 
        {
            "class": "CommandLineTool", 
            "hints": [
                {
                    "class": "DockerRequirement", 
                    "dockerPull": "miasteinberg/trim-galore"
                }
            ], 
            "inputs": [
                {
                    "type": "boolean", 
                    "inputBinding": {
                        "position": 1, 
                        "prefix": "--paired"
                    }, 
                    "id": "#trim_galore.cwl/paired"
                }, 
                {
                    "type": {
                        "type": "array", 
                        "items": "File"
                    }, 
                    "inputBinding": {
                        "position": 3
                    }, 
                    "id": "#trim_galore.cwl/reads"
                }
            ], 
            "outputs": [
                {
                    "type": {
                        "type": "array", 
                        "items": "File"
                    }, 
                    "outputBinding": {
                        "glob": "*_trimming_report.txt"
                    }, 
                    "id": "#trim_galore.cwl/trim_reports"
                }, 
                {
                    "type": {
                        "type": "array", 
                        "items": "File"
                    }, 
                    "outputBinding": {
                        "glob": "*_val_*.fq*"
                    }, 
                    "id": "#trim_galore.cwl/trimmed_reads"
                }
            ], 
            "baseCommand": "trim_galore", 
            "arguments": [
                {
                    "valueFrom": "$(runtime.outdir)", 
                    "prefix": "-o", 
                    "position": 2
                }
            ], 
            "id": "#trim_galore.cwl"
        }, 
        {
            "class": "Workflow", 
            "requirements": [
                {
                    "class": "ScatterFeatureRequirement"
                }
            ], 
            "inputs": [
                {
                    "type": "File", 
                    "id": "#exomeseq-01-preprocessing.cwl/GATKJar"
                }, 
                {
                    "type": [
                        "null", 
                        {
                            "type": "array", 
                            "items": "string"
                        }
                    ], 
                    "id": "#exomeseq-01-preprocessing.cwl/field_order"
                }, 
                {
                    "type": [
                        "null", 
                        {
                            "type": "array", 
                            "items": "string"
                        }
                    ], 
                    "id": "#exomeseq-01-preprocessing.cwl/intervals"
                }, 
                {
                    "type": {
                        "type": "array", 
                        "items": "File"
                    }, 
                    "id": "#exomeseq-01-preprocessing.cwl/knownSites"
                }, 
                {
                    "type": "string", 
                    "id": "#exomeseq-01-preprocessing.cwl/library"
                }, 
                {
                    "type": "string", 
                    "id": "#exomeseq-01-preprocessing.cwl/platform"
                }, 
                {
                    "type": {
                        "type": "array", 
                        "items": "File"
                    }, 
                    "id": "#exomeseq-01-preprocessing.cwl/reads"
                }, 
                {
                    "type": "File", 
                    "id": "#exomeseq-01-preprocessing.cwl/reference_genome"
                }, 
                {
                    "type": [
                        "null", 
                        "int"
                    ], 
                    "id": "#exomeseq-01-preprocessing.cwl/threads"
                }
            ], 
            "outputs": [
                {
                    "type": {
                        "type": "array", 
                        "items": "File"
                    }, 
                    "outputSource": "#exomeseq-01-preprocessing.cwl/qc/output_qc_report", 
                    "id": "#exomeseq-01-preprocessing.cwl/qc_reports"
                }, 
                {
                    "type": "File", 
                    "outputSource": "#exomeseq-01-preprocessing.cwl/recalibrate_04_apply/output_printReads", 
                    "id": "#exomeseq-01-preprocessing.cwl/recalibrated_reads"
                }, 
                {
                    "type": "File", 
                    "outputSource": "#exomeseq-01-preprocessing.cwl/recalibrate_02_covariation/output_baseRecalibrator", 
                    "id": "#exomeseq-01-preprocessing.cwl/recalibration_after"
                }, 
                {
                    "type": "File", 
                    "outputSource": "#exomeseq-01-preprocessing.cwl/recalibrate_01_analyze/output_baseRecalibrator", 
                    "id": "#exomeseq-01-preprocessing.cwl/recalibration_before"
                }, 
                {
                    "type": "File", 
                    "outputSource": "#exomeseq-01-preprocessing.cwl/recalibrate_03_plots/output_recalibrationPlots", 
                    "id": "#exomeseq-01-preprocessing.cwl/recalibration_plots"
                }, 
                {
                    "type": {
                        "type": "array", 
                        "items": "File"
                    }, 
                    "outputSource": "#exomeseq-01-preprocessing.cwl/trim/trim_reports", 
                    "id": "#exomeseq-01-preprocessing.cwl/trim_reports"
                }
            ], 
            "steps": [
                {
                    "run": "#bwa-mem.cwl", 
                    "requirements": [
                        {
                            "class": "ResourceRequirement", 
                            "coresMin": 8, 
                            "ramMin": 16000
                        }
                    ], 
                    "in": [
                        {
                            "default": "mapped.bam", 
                            "id": "#exomeseq-01-preprocessing.cwl/map/output_filename"
                        }, 
                        {
                            "source": "#exomeseq-01-preprocessing.cwl/parse_read_group_header/read_group_header", 
                            "id": "#exomeseq-01-preprocessing.cwl/map/read_group_header"
                        }, 
                        {
                            "source": "#exomeseq-01-preprocessing.cwl/trim/trimmed_reads", 
                            "id": "#exomeseq-01-preprocessing.cwl/map/reads"
                        }, 
                        {
                            "source": "#exomeseq-01-preprocessing.cwl/reference_genome", 
                            "id": "#exomeseq-01-preprocessing.cwl/map/reference"
                        }, 
                        {
                            "source": "#exomeseq-01-preprocessing.cwl/threads", 
                            "id": "#exomeseq-01-preprocessing.cwl/map/threads"
                        }
                    ], 
                    "out": [
                        "#exomeseq-01-preprocessing.cwl/map/output"
                    ], 
                    "id": "#exomeseq-01-preprocessing.cwl/map"
                }, 
                {
                    "run": "#picard-MarkDuplicates.cwl", 
                    "requirements": [
                        {
                            "class": "ResourceRequirement", 
                            "coresMin": 1, 
                            "ramMin": 2500
                        }
                    ], 
                    "in": [
                        {
                            "source": "#exomeseq-01-preprocessing.cwl/sort/sorted", 
                            "id": "#exomeseq-01-preprocessing.cwl/mark_duplicates/input_file"
                        }
                    ], 
                    "out": [
                        "#exomeseq-01-preprocessing.cwl/mark_duplicates/output_metrics_file", 
                        "#exomeseq-01-preprocessing.cwl/mark_duplicates/output_dedup_bam_file"
                    ], 
                    "id": "#exomeseq-01-preprocessing.cwl/mark_duplicates"
                }, 
                {
                    "run": "#parse-read-group-header.cwl", 
                    "in": [
                        {
                            "source": "#exomeseq-01-preprocessing.cwl/field_order", 
                            "id": "#exomeseq-01-preprocessing.cwl/parse_read_group_header/field_order"
                        }, 
                        {
                            "source": "#exomeseq-01-preprocessing.cwl/library", 
                            "id": "#exomeseq-01-preprocessing.cwl/parse_read_group_header/library"
                        }, 
                        {
                            "source": "#exomeseq-01-preprocessing.cwl/platform", 
                            "id": "#exomeseq-01-preprocessing.cwl/parse_read_group_header/platform"
                        }, 
                        {
                            "source": "#exomeseq-01-preprocessing.cwl/reads", 
                            "id": "#exomeseq-01-preprocessing.cwl/parse_read_group_header/reads"
                        }
                    ], 
                    "out": [
                        "#exomeseq-01-preprocessing.cwl/parse_read_group_header/read_group_header"
                    ], 
                    "id": "#exomeseq-01-preprocessing.cwl/parse_read_group_header"
                }, 
                {
                    "run": "#fastqc.cwl", 
                    "requirements": [
                        {
                            "class": "ResourceRequirement", 
                            "coresMin": 4, 
                            "ramMin": 2500
                        }
                    ], 
                    "scatter": "#exomeseq-01-preprocessing.cwl/qc/input_fastq_file", 
                    "in": [
                        {
                            "source": "#exomeseq-01-preprocessing.cwl/reads", 
                            "id": "#exomeseq-01-preprocessing.cwl/qc/input_fastq_file"
                        }, 
                        {
                            "source": "#exomeseq-01-preprocessing.cwl/threads", 
                            "id": "#exomeseq-01-preprocessing.cwl/qc/threads"
                        }
                    ], 
                    "out": [
                        "#exomeseq-01-preprocessing.cwl/qc/output_qc_report"
                    ], 
                    "id": "#exomeseq-01-preprocessing.cwl/qc"
                }, 
                {
                    "run": "#GATK-BaseRecalibrator.cwl", 
                    "requirements": [
                        {
                            "class": "ResourceRequirement", 
                            "coresMin": 1, 
                            "ramMin": 2500
                        }
                    ], 
                    "in": [
                        {
                            "source": "#exomeseq-01-preprocessing.cwl/GATKJar", 
                            "id": "#exomeseq-01-preprocessing.cwl/recalibrate_01_analyze/GATKJar"
                        }, 
                        {
                            "source": "#exomeseq-01-preprocessing.cwl/mark_duplicates/output_dedup_bam_file", 
                            "id": "#exomeseq-01-preprocessing.cwl/recalibrate_01_analyze/inputBam_BaseRecalibrator"
                        }, 
                        {
                            "source": "#exomeseq-01-preprocessing.cwl/intervals", 
                            "id": "#exomeseq-01-preprocessing.cwl/recalibrate_01_analyze/intervals"
                        }, 
                        {
                            "source": "#exomeseq-01-preprocessing.cwl/knownSites", 
                            "id": "#exomeseq-01-preprocessing.cwl/recalibrate_01_analyze/knownSites"
                        }, 
                        {
                            "default": "recal_data.table", 
                            "id": "#exomeseq-01-preprocessing.cwl/recalibrate_01_analyze/outputfile_BaseRecalibrator"
                        }, 
                        {
                            "source": "#exomeseq-01-preprocessing.cwl/reference_genome", 
                            "id": "#exomeseq-01-preprocessing.cwl/recalibrate_01_analyze/reference"
                        }
                    ], 
                    "out": [
                        "#exomeseq-01-preprocessing.cwl/recalibrate_01_analyze/output_baseRecalibrator"
                    ], 
                    "id": "#exomeseq-01-preprocessing.cwl/recalibrate_01_analyze"
                }, 
                {
                    "run": "#GATK-BaseRecalibrator.cwl", 
                    "requirements": [
                        {
                            "class": "ResourceRequirement", 
                            "coresMin": 1, 
                            "ramMin": 2500
                        }
                    ], 
                    "in": [
                        {
                            "source": "#exomeseq-01-preprocessing.cwl/GATKJar", 
                            "id": "#exomeseq-01-preprocessing.cwl/recalibrate_02_covariation/GATKJar"
                        }, 
                        {
                            "source": "#exomeseq-01-preprocessing.cwl/recalibrate_01_analyze/output_baseRecalibrator", 
                            "id": "#exomeseq-01-preprocessing.cwl/recalibrate_02_covariation/bqsr"
                        }, 
                        {
                            "source": "#exomeseq-01-preprocessing.cwl/mark_duplicates/output_dedup_bam_file", 
                            "id": "#exomeseq-01-preprocessing.cwl/recalibrate_02_covariation/inputBam_BaseRecalibrator"
                        }, 
                        {
                            "source": "#exomeseq-01-preprocessing.cwl/intervals", 
                            "id": "#exomeseq-01-preprocessing.cwl/recalibrate_02_covariation/intervals"
                        }, 
                        {
                            "source": "#exomeseq-01-preprocessing.cwl/knownSites", 
                            "id": "#exomeseq-01-preprocessing.cwl/recalibrate_02_covariation/knownSites"
                        }, 
                        {
                            "default": "post_recal_data.table", 
                            "id": "#exomeseq-01-preprocessing.cwl/recalibrate_02_covariation/outputfile_BaseRecalibrator"
                        }, 
                        {
                            "source": "#exomeseq-01-preprocessing.cwl/reference_genome", 
                            "id": "#exomeseq-01-preprocessing.cwl/recalibrate_02_covariation/reference"
                        }
                    ], 
                    "out": [
                        "#exomeseq-01-preprocessing.cwl/recalibrate_02_covariation/output_baseRecalibrator"
                    ], 
                    "id": "#exomeseq-01-preprocessing.cwl/recalibrate_02_covariation"
                }, 
                {
                    "run": "#GATK-AnalyzeCovariates.cwl", 
                    "requirements": [
                        {
                            "class": "ResourceRequirement", 
                            "coresMin": 1, 
                            "ramMin": 2500
                        }
                    ], 
                    "in": [
                        {
                            "source": "#exomeseq-01-preprocessing.cwl/GATKJar", 
                            "id": "#exomeseq-01-preprocessing.cwl/recalibrate_03_plots/GATKJar"
                        }, 
                        {
                            "source": "#exomeseq-01-preprocessing.cwl/mark_duplicates/output_dedup_bam_file", 
                            "id": "#exomeseq-01-preprocessing.cwl/recalibrate_03_plots/inputBam_BaseRecalibrator"
                        }, 
                        {
                            "source": "#exomeseq-01-preprocessing.cwl/recalibrate_02_covariation/output_baseRecalibrator", 
                            "id": "#exomeseq-01-preprocessing.cwl/recalibrate_03_plots/inputTable_after"
                        }, 
                        {
                            "source": "#exomeseq-01-preprocessing.cwl/recalibrate_01_analyze/output_baseRecalibrator", 
                            "id": "#exomeseq-01-preprocessing.cwl/recalibrate_03_plots/inputTable_before"
                        }, 
                        {
                            "source": "#exomeseq-01-preprocessing.cwl/intervals", 
                            "id": "#exomeseq-01-preprocessing.cwl/recalibrate_03_plots/intervals"
                        }, 
                        {
                            "default": "recalibration_plots.pdf", 
                            "id": "#exomeseq-01-preprocessing.cwl/recalibrate_03_plots/outputfile_recalibrationPlots"
                        }, 
                        {
                            "source": "#exomeseq-01-preprocessing.cwl/reference_genome", 
                            "id": "#exomeseq-01-preprocessing.cwl/recalibrate_03_plots/reference"
                        }
                    ], 
                    "out": [
                        "#exomeseq-01-preprocessing.cwl/recalibrate_03_plots/output_recalibrationPlots"
                    ], 
                    "id": "#exomeseq-01-preprocessing.cwl/recalibrate_03_plots"
                }, 
                {
                    "run": "#GATK-PrintReads.cwl", 
                    "requirements": [
                        {
                            "class": "ResourceRequirement", 
                            "coresMin": 1, 
                            "ramMin": 2500
                        }
                    ], 
                    "in": [
                        {
                            "source": "#exomeseq-01-preprocessing.cwl/GATKJar", 
                            "id": "#exomeseq-01-preprocessing.cwl/recalibrate_04_apply/GATKJar"
                        }, 
                        {
                            "source": "#exomeseq-01-preprocessing.cwl/mark_duplicates/output_dedup_bam_file", 
                            "id": "#exomeseq-01-preprocessing.cwl/recalibrate_04_apply/inputBam_printReads"
                        }, 
                        {
                            "source": "#exomeseq-01-preprocessing.cwl/recalibrate_01_analyze/output_baseRecalibrator", 
                            "id": "#exomeseq-01-preprocessing.cwl/recalibrate_04_apply/input_baseRecalibrator"
                        }, 
                        {
                            "source": "#exomeseq-01-preprocessing.cwl/intervals", 
                            "id": "#exomeseq-01-preprocessing.cwl/recalibrate_04_apply/intervals"
                        }, 
                        {
                            "default": "recal_reads.bam", 
                            "id": "#exomeseq-01-preprocessing.cwl/recalibrate_04_apply/outputfile_printReads"
                        }, 
                        {
                            "source": "#exomeseq-01-preprocessing.cwl/reference_genome", 
                            "id": "#exomeseq-01-preprocessing.cwl/recalibrate_04_apply/reference"
                        }
                    ], 
                    "out": [
                        "#exomeseq-01-preprocessing.cwl/recalibrate_04_apply/output_printReads"
                    ], 
                    "id": "#exomeseq-01-preprocessing.cwl/recalibrate_04_apply"
                }, 
                {
                    "run": "#picard-SortSam.cwl", 
                    "requirements": [
                        {
                            "class": "ResourceRequirement", 
                            "coresMin": 1, 
                            "ramMin": 2500
                        }
                    ], 
                    "in": [
                        {
                            "source": "#exomeseq-01-preprocessing.cwl/map/output", 
                            "id": "#exomeseq-01-preprocessing.cwl/sort/input_file"
                        }
                    ], 
                    "out": [
                        "#exomeseq-01-preprocessing.cwl/sort/sorted"
                    ], 
                    "id": "#exomeseq-01-preprocessing.cwl/sort"
                }, 
                {
                    "run": "#trim_galore.cwl", 
                    "requirements": [
                        {
                            "class": "ResourceRequirement", 
                            "coresMin": 4, 
                            "ramMin": 8000
                        }
                    ], 
                    "in": [
                        {
                            "default": true, 
                            "id": "#exomeseq-01-preprocessing.cwl/trim/paired"
                        }, 
                        {
                            "source": "#exomeseq-01-preprocessing.cwl/reads", 
                            "id": "#exomeseq-01-preprocessing.cwl/trim/reads"
                        }
                    ], 
                    "out": [
                        "#exomeseq-01-preprocessing.cwl/trim/trimmed_reads", 
                        "#exomeseq-01-preprocessing.cwl/trim/trim_reports"
                    ], 
                    "id": "#exomeseq-01-preprocessing.cwl/trim"
                }
            ], 
            "id": "#exomeseq-01-preprocessing.cwl"
        }, 
        {
            "class": "Workflow", 
            "requirements": [
                {
                    "class": "ScatterFeatureRequirement"
                }
            ], 
            "inputs": [
                {
                    "type": "File", 
                    "id": "#exomeseq-02-variantdiscovery.cwl/GATKJar"
                }, 
                {
                    "type": "File", 
                    "id": "#exomeseq-02-variantdiscovery.cwl/indel_resource_mills"
                }, 
                {
                    "type": [
                        "null", 
                        {
                            "type": "array", 
                            "items": "string"
                        }
                    ], 
                    "id": "#exomeseq-02-variantdiscovery.cwl/intervals"
                }, 
                {
                    "type": {
                        "type": "array", 
                        "items": "File"
                    }, 
                    "id": "#exomeseq-02-variantdiscovery.cwl/mapped_reads"
                }, 
                {
                    "type": "File", 
                    "id": "#exomeseq-02-variantdiscovery.cwl/reference_genome"
                }, 
                {
                    "type": "File", 
                    "id": "#exomeseq-02-variantdiscovery.cwl/resource_dbsnp"
                }, 
                {
                    "type": "File", 
                    "id": "#exomeseq-02-variantdiscovery.cwl/snp_resource_1kg"
                }, 
                {
                    "type": "File", 
                    "id": "#exomeseq-02-variantdiscovery.cwl/snp_resource_hapmap"
                }, 
                {
                    "type": "File", 
                    "id": "#exomeseq-02-variantdiscovery.cwl/snp_resource_omni"
                }, 
                {
                    "type": "double", 
                    "id": "#exomeseq-02-variantdiscovery.cwl/stand_call_conf"
                }, 
                {
                    "type": [
                        "null", 
                        "int"
                    ], 
                    "id": "#exomeseq-02-variantdiscovery.cwl/threads"
                }
            ], 
            "outputs": [
                {
                    "type": "File", 
                    "outputSource": "#exomeseq-02-variantdiscovery.cwl/joint_genotyping/output_GenotypeGVCFs", 
                    "doc": "VCF file from joint genotyping calling", 
                    "id": "#exomeseq-02-variantdiscovery.cwl/joint_raw_variants"
                }, 
                {
                    "type": {
                        "type": "array", 
                        "items": "File"
                    }, 
                    "outputSource": "#exomeseq-02-variantdiscovery.cwl/variant_calling/output_HaplotypeCaller", 
                    "doc": "VCF files from per sample variant calling", 
                    "id": "#exomeseq-02-variantdiscovery.cwl/per_sample_raw_variants"
                }, 
                {
                    "type": "File", 
                    "outputSource": "#exomeseq-02-variantdiscovery.cwl/variant_recalibration_indels/recal_File", 
                    "doc": "The output recal file used by ApplyRecalibration in INDEL mode", 
                    "id": "#exomeseq-02-variantdiscovery.cwl/variant_recalibration_indels_recal"
                }, 
                {
                    "type": "File", 
                    "outputSource": "#exomeseq-02-variantdiscovery.cwl/variant_recalibration_indels/vqsr_rscript", 
                    "doc": "The output rscript file generated by the VQSR in INDEL mode to aid in visualization of the input data and learned model", 
                    "id": "#exomeseq-02-variantdiscovery.cwl/variant_recalibration_indels_rscript"
                }, 
                {
                    "type": "File", 
                    "outputSource": "#exomeseq-02-variantdiscovery.cwl/variant_recalibration_indels/tranches_File", 
                    "doc": "The output tranches file used by ApplyRecalibration in INDEL mode", 
                    "id": "#exomeseq-02-variantdiscovery.cwl/variant_recalibration_indels_tranches"
                }, 
                {
                    "type": "File", 
                    "outputSource": "#exomeseq-02-variantdiscovery.cwl/apply_recalibration_indels/output_recalibrated_vcf", 
                    "doc": "The output filtered and recalibrated VCF file in INDEL mode in which each variant is annotated with its VQSLOD value", 
                    "id": "#exomeseq-02-variantdiscovery.cwl/variant_recalibration_indels_vcf"
                }, 
                {
                    "type": "File", 
                    "outputSource": "#exomeseq-02-variantdiscovery.cwl/variant_recalibration_snps/recal_File", 
                    "doc": "The output recal file used by ApplyRecalibration in SNP mode", 
                    "id": "#exomeseq-02-variantdiscovery.cwl/variant_recalibration_snps_recal"
                }, 
                {
                    "type": "File", 
                    "outputSource": "#exomeseq-02-variantdiscovery.cwl/variant_recalibration_snps/vqsr_rscript", 
                    "doc": "The output rscript file generated by the VQSR in SNP mode to aid in visualization of the input data and learned model", 
                    "id": "#exomeseq-02-variantdiscovery.cwl/variant_recalibration_snps_rscript"
                }, 
                {
                    "type": "File", 
                    "outputSource": "#exomeseq-02-variantdiscovery.cwl/variant_recalibration_snps/tranches_File", 
                    "doc": "The output tranches file used by ApplyRecalibration in SNP mode", 
                    "id": "#exomeseq-02-variantdiscovery.cwl/variant_recalibration_snps_tranches"
                }, 
                {
                    "type": "File", 
                    "outputSource": "#exomeseq-02-variantdiscovery.cwl/apply_recalibration_snps/output_recalibrated_vcf", 
                    "doc": "The output filtered and recalibrated VCF file in SNP mode in which each variant is annotated with its VQSLOD value", 
                    "id": "#exomeseq-02-variantdiscovery.cwl/variant_recalibration_snps_vcf"
                }
            ], 
            "steps": [
                {
                    "run": "#GATK-ApplyRecalibration.cwl", 
                    "in": [
                        {
                            "source": "#exomeseq-02-variantdiscovery.cwl/GATKJar", 
                            "id": "#exomeseq-02-variantdiscovery.cwl/apply_recalibration_indels/GATKJar"
                        }, 
                        {
                            "source": "#exomeseq-02-variantdiscovery.cwl/intervals", 
                            "id": "#exomeseq-02-variantdiscovery.cwl/apply_recalibration_indels/intervals"
                        }, 
                        {
                            "default": "INDEL", 
                            "id": "#exomeseq-02-variantdiscovery.cwl/apply_recalibration_indels/mode"
                        }, 
                        {
                            "default": "indels_recalibrated.vcf", 
                            "id": "#exomeseq-02-variantdiscovery.cwl/apply_recalibration_indels/outputfile_recalibrated_vcf"
                        }, 
                        {
                            "source": "#exomeseq-02-variantdiscovery.cwl/variant_recalibration_indels/recal_File", 
                            "id": "#exomeseq-02-variantdiscovery.cwl/apply_recalibration_indels/recal_file"
                        }, 
                        {
                            "source": "#exomeseq-02-variantdiscovery.cwl/reference_genome", 
                            "id": "#exomeseq-02-variantdiscovery.cwl/apply_recalibration_indels/reference"
                        }, 
                        {
                            "source": "#exomeseq-02-variantdiscovery.cwl/threads", 
                            "id": "#exomeseq-02-variantdiscovery.cwl/apply_recalibration_indels/threads"
                        }, 
                        {
                            "source": "#exomeseq-02-variantdiscovery.cwl/variant_recalibration_indels/tranches_File", 
                            "id": "#exomeseq-02-variantdiscovery.cwl/apply_recalibration_indels/tranches_file"
                        }, 
                        {
                            "default": 99.0, 
                            "id": "#exomeseq-02-variantdiscovery.cwl/apply_recalibration_indels/ts_filter_level"
                        }, 
                        {
                            "source": "#exomeseq-02-variantdiscovery.cwl/joint_genotyping/output_GenotypeGVCFs", 
                            "id": "#exomeseq-02-variantdiscovery.cwl/apply_recalibration_indels/variants"
                        }
                    ], 
                    "out": [
                        "#exomeseq-02-variantdiscovery.cwl/apply_recalibration_indels/output_recalibrated_vcf"
                    ], 
                    "id": "#exomeseq-02-variantdiscovery.cwl/apply_recalibration_indels"
                }, 
                {
                    "run": "#GATK-ApplyRecalibration.cwl", 
                    "in": [
                        {
                            "source": "#exomeseq-02-variantdiscovery.cwl/GATKJar", 
                            "id": "#exomeseq-02-variantdiscovery.cwl/apply_recalibration_snps/GATKJar"
                        }, 
                        {
                            "source": "#exomeseq-02-variantdiscovery.cwl/intervals", 
                            "id": "#exomeseq-02-variantdiscovery.cwl/apply_recalibration_snps/intervals"
                        }, 
                        {
                            "default": "SNP", 
                            "id": "#exomeseq-02-variantdiscovery.cwl/apply_recalibration_snps/mode"
                        }, 
                        {
                            "default": "snps_recalibrated.vcf", 
                            "id": "#exomeseq-02-variantdiscovery.cwl/apply_recalibration_snps/outputfile_recalibrated_vcf"
                        }, 
                        {
                            "source": "#exomeseq-02-variantdiscovery.cwl/variant_recalibration_snps/recal_File", 
                            "id": "#exomeseq-02-variantdiscovery.cwl/apply_recalibration_snps/recal_file"
                        }, 
                        {
                            "source": "#exomeseq-02-variantdiscovery.cwl/reference_genome", 
                            "id": "#exomeseq-02-variantdiscovery.cwl/apply_recalibration_snps/reference"
                        }, 
                        {
                            "source": "#exomeseq-02-variantdiscovery.cwl/threads", 
                            "id": "#exomeseq-02-variantdiscovery.cwl/apply_recalibration_snps/threads"
                        }, 
                        {
                            "source": "#exomeseq-02-variantdiscovery.cwl/variant_recalibration_snps/tranches_File", 
                            "id": "#exomeseq-02-variantdiscovery.cwl/apply_recalibration_snps/tranches_file"
                        }, 
                        {
                            "default": 99.5, 
                            "id": "#exomeseq-02-variantdiscovery.cwl/apply_recalibration_snps/ts_filter_level"
                        }, 
                        {
                            "source": "#exomeseq-02-variantdiscovery.cwl/joint_genotyping/output_GenotypeGVCFs", 
                            "id": "#exomeseq-02-variantdiscovery.cwl/apply_recalibration_snps/variants"
                        }
                    ], 
                    "out": [
                        "#exomeseq-02-variantdiscovery.cwl/apply_recalibration_snps/output_recalibrated_vcf"
                    ], 
                    "id": "#exomeseq-02-variantdiscovery.cwl/apply_recalibration_snps"
                }, 
                {
                    "run": "#GATK-GenotypeGVCFs.cwl", 
                    "requirements": [
                        {
                            "class": "ResourceRequirement", 
                            "coresMin": 1, 
                            "ramMin": 12288
                        }
                    ], 
                    "in": [
                        {
                            "source": "#exomeseq-02-variantdiscovery.cwl/GATKJar", 
                            "id": "#exomeseq-02-variantdiscovery.cwl/joint_genotyping/GATKJar"
                        }, 
                        {
                            "source": "#exomeseq-02-variantdiscovery.cwl/intervals", 
                            "id": "#exomeseq-02-variantdiscovery.cwl/joint_genotyping/intervals"
                        }, 
                        {
                            "default": "joint_genotype_raw_variants.g.vcf", 
                            "id": "#exomeseq-02-variantdiscovery.cwl/joint_genotyping/outputfile_GenotypeGVCFs"
                        }, 
                        {
                            "source": "#exomeseq-02-variantdiscovery.cwl/reference_genome", 
                            "id": "#exomeseq-02-variantdiscovery.cwl/joint_genotyping/reference"
                        }, 
                        {
                            "default": 1, 
                            "id": "#exomeseq-02-variantdiscovery.cwl/joint_genotyping/threads"
                        }, 
                        {
                            "source": "#exomeseq-02-variantdiscovery.cwl/variant_calling/output_HaplotypeCaller", 
                            "id": "#exomeseq-02-variantdiscovery.cwl/joint_genotyping/variants"
                        }
                    ], 
                    "out": [
                        "#exomeseq-02-variantdiscovery.cwl/joint_genotyping/output_GenotypeGVCFs"
                    ], 
                    "id": "#exomeseq-02-variantdiscovery.cwl/joint_genotyping"
                }, 
                {
                    "run": "#GATK-HaplotypeCaller.cwl", 
                    "requirements": [
                        {
                            "class": "ResourceRequirement", 
                            "coresMin": 1, 
                            "ramMin": 2560
                        }
                    ], 
                    "scatter": "#exomeseq-02-variantdiscovery.cwl/variant_calling/inputBam_HaplotypeCaller", 
                    "in": [
                        {
                            "source": "#exomeseq-02-variantdiscovery.cwl/GATKJar", 
                            "id": "#exomeseq-02-variantdiscovery.cwl/variant_calling/GATKJar"
                        }, 
                        {
                            "default": "GVCF", 
                            "id": "#exomeseq-02-variantdiscovery.cwl/variant_calling/emitRefConfidence"
                        }, 
                        {
                            "default": "DISCOVERY", 
                            "id": "#exomeseq-02-variantdiscovery.cwl/variant_calling/genotyping_mode"
                        }, 
                        {
                            "source": "#exomeseq-02-variantdiscovery.cwl/mapped_reads", 
                            "id": "#exomeseq-02-variantdiscovery.cwl/variant_calling/inputBam_HaplotypeCaller"
                        }, 
                        {
                            "source": "#exomeseq-02-variantdiscovery.cwl/intervals", 
                            "id": "#exomeseq-02-variantdiscovery.cwl/variant_calling/intervals"
                        }, 
                        {
                            "default": "raw_variants.g.vcf", 
                            "id": "#exomeseq-02-variantdiscovery.cwl/variant_calling/outputfile_HaplotypeCaller"
                        }, 
                        {
                            "source": "#exomeseq-02-variantdiscovery.cwl/reference_genome", 
                            "id": "#exomeseq-02-variantdiscovery.cwl/variant_calling/reference"
                        }, 
                        {
                            "source": "#exomeseq-02-variantdiscovery.cwl/stand_call_conf", 
                            "id": "#exomeseq-02-variantdiscovery.cwl/variant_calling/stand_call_conf"
                        }
                    ], 
                    "out": [
                        "#exomeseq-02-variantdiscovery.cwl/variant_calling/output_HaplotypeCaller"
                    ], 
                    "id": "#exomeseq-02-variantdiscovery.cwl/variant_calling"
                }, 
                {
                    "run": "#GATK-VariantRecalibrator-Indels.cwl", 
                    "in": [
                        {
                            "source": "#exomeseq-02-variantdiscovery.cwl/GATKJar", 
                            "id": "#exomeseq-02-variantdiscovery.cwl/variant_recalibration_indels/GATKJar"
                        }, 
                        {
                            "default": [
                                "QD", 
                                "FS", 
                                "SOR", 
                                "ReadPosRankSum", 
                                "MQRankSum"
                            ], 
                            "id": "#exomeseq-02-variantdiscovery.cwl/variant_recalibration_indels/annotations"
                        }, 
                        {
                            "source": "#exomeseq-02-variantdiscovery.cwl/intervals", 
                            "id": "#exomeseq-02-variantdiscovery.cwl/variant_recalibration_indels/intervals"
                        }, 
                        {
                            "default": "indels_vqsr_recal.out", 
                            "id": "#exomeseq-02-variantdiscovery.cwl/variant_recalibration_indels/outputfile_recal"
                        }, 
                        {
                            "default": "indels_vqsr.R", 
                            "id": "#exomeseq-02-variantdiscovery.cwl/variant_recalibration_indels/outputfile_rscript"
                        }, 
                        {
                            "default": "indels_vqsr_tranches.out", 
                            "id": "#exomeseq-02-variantdiscovery.cwl/variant_recalibration_indels/outputfile_tranches"
                        }, 
                        {
                            "source": "#exomeseq-02-variantdiscovery.cwl/reference_genome", 
                            "id": "#exomeseq-02-variantdiscovery.cwl/variant_recalibration_indels/reference"
                        }, 
                        {
                            "source": "#exomeseq-02-variantdiscovery.cwl/resource_dbsnp", 
                            "id": "#exomeseq-02-variantdiscovery.cwl/variant_recalibration_indels/resource_dbsnp"
                        }, 
                        {
                            "source": "#exomeseq-02-variantdiscovery.cwl/indel_resource_mills", 
                            "id": "#exomeseq-02-variantdiscovery.cwl/variant_recalibration_indels/resource_mills"
                        }, 
                        {
                            "default": 1, 
                            "id": "#exomeseq-02-variantdiscovery.cwl/variant_recalibration_indels/threads"
                        }, 
                        {
                            "source": "#exomeseq-02-variantdiscovery.cwl/joint_genotyping/output_GenotypeGVCFs", 
                            "id": "#exomeseq-02-variantdiscovery.cwl/variant_recalibration_indels/variants"
                        }
                    ], 
                    "out": [
                        "#exomeseq-02-variantdiscovery.cwl/variant_recalibration_indels/tranches_File", 
                        "#exomeseq-02-variantdiscovery.cwl/variant_recalibration_indels/recal_File", 
                        "#exomeseq-02-variantdiscovery.cwl/variant_recalibration_indels/vqsr_rscript"
                    ], 
                    "id": "#exomeseq-02-variantdiscovery.cwl/variant_recalibration_indels"
                }, 
                {
                    "run": "#GATK-VariantRecalibrator-SNPs.cwl", 
                    "in": [
                        {
                            "source": "#exomeseq-02-variantdiscovery.cwl/GATKJar", 
                            "id": "#exomeseq-02-variantdiscovery.cwl/variant_recalibration_snps/GATKJar"
                        }, 
                        {
                            "default": [
                                "QD", 
                                "MQ", 
                                "MQRankSum", 
                                "ReadPosRankSum", 
                                "FS", 
                                "SOR"
                            ], 
                            "id": "#exomeseq-02-variantdiscovery.cwl/variant_recalibration_snps/annotations"
                        }, 
                        {
                            "source": "#exomeseq-02-variantdiscovery.cwl/intervals", 
                            "id": "#exomeseq-02-variantdiscovery.cwl/variant_recalibration_snps/intervals"
                        }, 
                        {
                            "default": "snps_vqsr_recal.out", 
                            "id": "#exomeseq-02-variantdiscovery.cwl/variant_recalibration_snps/outputfile_recal"
                        }, 
                        {
                            "default": "snps_vqsr.R", 
                            "id": "#exomeseq-02-variantdiscovery.cwl/variant_recalibration_snps/outputfile_rscript"
                        }, 
                        {
                            "default": "snps_vqsr_tranches.out", 
                            "id": "#exomeseq-02-variantdiscovery.cwl/variant_recalibration_snps/outputfile_tranches"
                        }, 
                        {
                            "source": "#exomeseq-02-variantdiscovery.cwl/reference_genome", 
                            "id": "#exomeseq-02-variantdiscovery.cwl/variant_recalibration_snps/reference"
                        }, 
                        {
                            "source": "#exomeseq-02-variantdiscovery.cwl/snp_resource_1kg", 
                            "id": "#exomeseq-02-variantdiscovery.cwl/variant_recalibration_snps/resource_1kg"
                        }, 
                        {
                            "source": "#exomeseq-02-variantdiscovery.cwl/resource_dbsnp", 
                            "id": "#exomeseq-02-variantdiscovery.cwl/variant_recalibration_snps/resource_dbsnp"
                        }, 
                        {
                            "source": "#exomeseq-02-variantdiscovery.cwl/snp_resource_hapmap", 
                            "id": "#exomeseq-02-variantdiscovery.cwl/variant_recalibration_snps/resource_hapmap"
                        }, 
                        {
                            "source": "#exomeseq-02-variantdiscovery.cwl/snp_resource_omni", 
                            "id": "#exomeseq-02-variantdiscovery.cwl/variant_recalibration_snps/resource_omni"
                        }, 
                        {
                            "default": 1, 
                            "id": "#exomeseq-02-variantdiscovery.cwl/variant_recalibration_snps/threads"
                        }, 
                        {
                            "source": "#exomeseq-02-variantdiscovery.cwl/joint_genotyping/output_GenotypeGVCFs", 
                            "id": "#exomeseq-02-variantdiscovery.cwl/variant_recalibration_snps/variants"
                        }
                    ], 
                    "out": [
                        "#exomeseq-02-variantdiscovery.cwl/variant_recalibration_snps/tranches_File", 
                        "#exomeseq-02-variantdiscovery.cwl/variant_recalibration_snps/recal_File", 
                        "#exomeseq-02-variantdiscovery.cwl/variant_recalibration_snps/vqsr_rscript"
                    ], 
                    "id": "#exomeseq-02-variantdiscovery.cwl/variant_recalibration_snps"
                }
            ], 
            "id": "#exomeseq-02-variantdiscovery.cwl"
        }, 
        {
            "class": "Workflow", 
            "label": "Whole Exome Sequencing", 
            "doc": "Whole Exome Sequence analysis using GATK best practices - Germline SNP & Indel Discovery\n", 
            "requirements": [
                {
                    "class": "ScatterFeatureRequirement"
                }, 
                {
                    "class": "SubworkflowFeatureRequirement"
                }
            ], 
            "inputs": [
                {
                    "type": "File", 
                    "id": "#main/GATKJar"
                }, 
                {
                    "type": [
                        "null", 
                        {
                            "type": "array", 
                            "items": "string"
                        }
                    ], 
                    "id": "#main/field_order"
                }, 
                {
                    "type": "File", 
                    "secondaryFiles": [
                        ".idx"
                    ], 
                    "id": "#main/indel_resource_mills"
                }, 
                {
                    "type": [
                        "null", 
                        {
                            "type": "array", 
                            "items": "string"
                        }
                    ], 
                    "id": "#main/intervals"
                }, 
                {
                    "type": {
                        "type": "array", 
                        "items": "File"
                    }, 
                    "secondaryFiles": [
                        ".idx"
                    ], 
                    "id": "#main/knownSites"
                }, 
                {
                    "type": "string", 
                    "id": "#main/library"
                }, 
                {
                    "type": "string", 
                    "id": "#main/platform"
                }, 
                {
                    "type": {
                        "type": "array", 
                        "items": {
                            "type": "array", 
                            "items": "File"
                        }
                    }, 
                    "id": "#main/read_pairs"
                }, 
                {
                    "type": "File", 
                    "secondaryFiles": [
                        ".amb", 
                        ".ann", 
                        ".bwt", 
                        ".pac", 
                        ".sa", 
                        ".fai", 
                        "^.dict"
                    ], 
                    "id": "#main/reference_genome"
                }, 
                {
                    "type": {
                        "type": "array", 
                        "items": "File"
                    }, 
                    "secondaryFiles": [
                        "^.bai"
                    ], 
                    "id": "#main/reference_reads"
                }, 
                {
                    "type": "File", 
                    "secondaryFiles": [
                        ".idx"
                    ], 
                    "id": "#main/resource_dbsnp"
                }, 
                {
                    "type": "File", 
                    "secondaryFiles": [
                        ".idx"
                    ], 
                    "id": "#main/snp_resource_1kg"
                }, 
                {
                    "type": "File", 
                    "secondaryFiles": [
                        ".idx"
                    ], 
                    "id": "#main/snp_resource_hapmap"
                }, 
                {
                    "type": "File", 
                    "secondaryFiles": [
                        ".idx"
                    ], 
                    "id": "#main/snp_resource_omni"
                }, 
                {
                    "type": "double", 
                    "id": "#main/stand_call_conf"
                }, 
                {
                    "type": [
                        "null", 
                        "int"
                    ], 
                    "id": "#main/threads"
                }
            ], 
            "outputs": [
                {
                    "type": "File", 
                    "outputSource": "#main/variant_discovery/joint_raw_variants", 
                    "doc": "VCF file from joint genotyping calling", 
                    "id": "#main/joint_raw_variants"
                }, 
                {
                    "type": {
                        "type": "array", 
                        "items": "File"
                    }, 
                    "outputSource": "#main/variant_discovery/per_sample_raw_variants", 
                    "doc": "VCF files from per sample variant calling", 
                    "id": "#main/per_sample_raw_variants"
                }, 
                {
                    "type": {
                        "type": "array", 
                        "items": {
                            "type": "array", 
                            "items": "File"
                        }
                    }, 
                    "outputSource": "#main/preprocessing/qc_reports", 
                    "id": "#main/qc_reports"
                }, 
                {
                    "type": {
                        "type": "array", 
                        "items": "File"
                    }, 
                    "outputSource": "#main/preprocessing/recalibrated_reads", 
                    "id": "#main/recalibrated_reads"
                }, 
                {
                    "type": {
                        "type": "array", 
                        "items": "File"
                    }, 
                    "outputSource": "#main/preprocessing/recalibration_after", 
                    "id": "#main/recalibration_after"
                }, 
                {
                    "type": {
                        "type": "array", 
                        "items": "File"
                    }, 
                    "outputSource": "#main/preprocessing/recalibration_before", 
                    "id": "#main/recalibration_before"
                }, 
                {
                    "type": {
                        "type": "array", 
                        "items": "File"
                    }, 
                    "outputSource": "#main/preprocessing/recalibration_plots", 
                    "id": "#main/recalibration_plots"
                }, 
                {
                    "type": {
                        "type": "array", 
                        "items": {
                            "type": "array", 
                            "items": "File"
                        }
                    }, 
                    "outputSource": "#main/preprocessing/trim_reports", 
                    "id": "#main/trim_reports"
                }, 
                {
                    "type": "File", 
                    "outputSource": "#main/variant_discovery/variant_recalibration_indels_recal", 
                    "doc": "The output recal file used by ApplyRecalibration in INDEL mode", 
                    "id": "#main/variant_recalibration_indels_recal"
                }, 
                {
                    "type": "File", 
                    "outputSource": "#main/variant_discovery/variant_recalibration_indels_rscript", 
                    "doc": "The output rscript file generated by the VQSR in INDEL mode to aid in visualization of the input data and learned model", 
                    "id": "#main/variant_recalibration_indels_rscript"
                }, 
                {
                    "type": "File", 
                    "outputSource": "#main/variant_discovery/variant_recalibration_indels_tranches", 
                    "doc": "The output tranches file used by ApplyRecalibration in INDEL mode", 
                    "id": "#main/variant_recalibration_indels_tranches"
                }, 
                {
                    "type": "File", 
                    "outputSource": "#main/variant_discovery/variant_recalibration_indels_vcf", 
                    "doc": "The output filtered and recalibrated VCF file in INDEL mode in which each variant is annotated with its VQSLOD value", 
                    "id": "#main/variant_recalibration_indels_vcf"
                }, 
                {
                    "type": "File", 
                    "outputSource": "#main/variant_discovery/variant_recalibration_snps_recal", 
                    "doc": "The output recal file used by ApplyRecalibration in SNP mode", 
                    "id": "#main/variant_recalibration_snps_recal"
                }, 
                {
                    "type": "File", 
                    "outputSource": "#main/variant_discovery/variant_recalibration_snps_rscript", 
                    "doc": "The output rscript file generated by the VQSR in SNP mode to aid in visualization of the input data and learned model", 
                    "id": "#main/variant_recalibration_snps_rscript"
                }, 
                {
                    "type": "File", 
                    "outputSource": "#main/variant_discovery/variant_recalibration_snps_tranches", 
                    "doc": "The output tranches file used by ApplyRecalibration in SNP mode", 
                    "id": "#main/variant_recalibration_snps_tranches"
                }, 
                {
                    "type": "File", 
                    "outputSource": "#main/variant_discovery/variant_recalibration_snps_vcf", 
                    "doc": "The output filtered and recalibrated VCF file in SNP mode in which each variant is annotated with its VQSLOD value", 
                    "id": "#main/variant_recalibration_snps_vcf"
                }
            ], 
            "steps": [
                {
                    "run": "#concat-file-arrays.cwl", 
                    "in": [
                        {
                            "source": "#main/preprocessing/recalibrated_reads", 
                            "id": "#main/add_samples/array1"
                        }, 
                        {
                            "source": "#main/reference_reads", 
                            "id": "#main/add_samples/array2"
                        }
                    ], 
                    "out": [
                        "#main/add_samples/output"
                    ], 
                    "id": "#main/add_samples"
                }, 
                {
                    "run": "#exomeseq-01-preprocessing.cwl", 
                    "scatter": "#main/preprocessing/reads", 
                    "in": [
                        {
                            "source": "#main/GATKJar", 
                            "id": "#main/preprocessing/GATKJar"
                        }, 
                        {
                            "source": "#main/field_order", 
                            "id": "#main/preprocessing/field_order"
                        }, 
                        {
                            "source": "#main/intervals", 
                            "id": "#main/preprocessing/intervals"
                        }, 
                        {
                            "source": "#main/knownSites", 
                            "id": "#main/preprocessing/knownSites"
                        }, 
                        {
                            "source": "#main/library", 
                            "id": "#main/preprocessing/library"
                        }, 
                        {
                            "source": "#main/platform", 
                            "id": "#main/preprocessing/platform"
                        }, 
                        {
                            "source": "#main/read_pairs", 
                            "id": "#main/preprocessing/reads"
                        }, 
                        {
                            "source": "#main/reference_genome", 
                            "id": "#main/preprocessing/reference_genome"
                        }, 
                        {
                            "source": "#main/threads", 
                            "id": "#main/preprocessing/threads"
                        }
                    ], 
                    "out": [
                        "#main/preprocessing/qc_reports", 
                        "#main/preprocessing/trim_reports", 
                        "#main/preprocessing/recalibration_before", 
                        "#main/preprocessing/recalibration_after", 
                        "#main/preprocessing/recalibration_plots", 
                        "#main/preprocessing/recalibrated_reads"
                    ], 
                    "id": "#main/preprocessing"
                }, 
                {
                    "run": "#exomeseq-02-variantdiscovery.cwl", 
                    "in": [
                        {
                            "source": "#main/GATKJar", 
                            "id": "#main/variant_discovery/GATKJar"
                        }, 
                        {
                            "source": "#main/indel_resource_mills", 
                            "id": "#main/variant_discovery/indel_resource_mills"
                        }, 
                        {
                            "source": "#main/intervals", 
                            "id": "#main/variant_discovery/intervals"
                        }, 
                        {
                            "source": "#main/add_samples/output", 
                            "id": "#main/variant_discovery/mapped_reads"
                        }, 
                        {
                            "source": "#main/reference_genome", 
                            "id": "#main/variant_discovery/reference_genome"
                        }, 
                        {
                            "source": "#main/resource_dbsnp", 
                            "id": "#main/variant_discovery/resource_dbsnp"
                        }, 
                        {
                            "source": "#main/snp_resource_1kg", 
                            "id": "#main/variant_discovery/snp_resource_1kg"
                        }, 
                        {
                            "source": "#main/snp_resource_hapmap", 
                            "id": "#main/variant_discovery/snp_resource_hapmap"
                        }, 
                        {
                            "source": "#main/snp_resource_omni", 
                            "id": "#main/variant_discovery/snp_resource_omni"
                        }, 
                        {
                            "source": "#main/stand_call_conf", 
                            "id": "#main/variant_discovery/stand_call_conf"
                        }, 
                        {
                            "source": "#main/threads", 
                            "id": "#main/variant_discovery/threads"
                        }
                    ], 
                    "out": [
                        "#main/variant_discovery/per_sample_raw_variants", 
                        "#main/variant_discovery/joint_raw_variants", 
                        "#main/variant_discovery/variant_recalibration_snps_tranches", 
                        "#main/variant_discovery/variant_recalibration_snps_recal", 
                        "#main/variant_discovery/variant_recalibration_snps_rscript", 
                        "#main/variant_discovery/variant_recalibration_indels_tranches", 
                        "#main/variant_discovery/variant_recalibration_indels_recal", 
                        "#main/variant_discovery/variant_recalibration_indels_rscript", 
                        "#main/variant_discovery/variant_recalibration_snps_vcf", 
                        "#main/variant_discovery/variant_recalibration_indels_vcf"
                    ], 
                    "id": "#main/variant_discovery"
                }
            ], 
            "id": "#main"
        }
    ]
}