#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { TRIMMOMATIC_PE            } from './modules/local/trimmomatic_pe/main.nf'
include { TRIMMOMATIC               } from './modules/nf-core/trimmomatic/main.nf'
include { FASTQC as FASTQC_PE       } from './modules/nf-core/fastqc/main'
include { FASTQC as FASTQC_VANILLA  } from './modules/nf-core/fastqc/main'

workflow  {
    TRIMMOMATIC_PARALLEL_NF()
}

workflow TRIMMOMATIC_PARALLEL_NF {

    ch_reads = Channel.of(
        [
            [
                id: file(params.reads_1).simpleName,
                single_end: false,
                run: 1,
            ],
            [
                file(params.reads_1, checkIfExists: true),
                file(params.reads_2, checkIfExists: true),
            ],
        ]
    )

    // MODULE: TRIMMOMATIC_PE
    TRIMMOMATIC_PE(
        ch_reads
    )

    // MODULE: FASTQC_PE
    FASTQC_PE (
        TRIMMOMATIC_PE.out.trimmed_reads
    )

    if ( params.run_vanilla_trimmomatic ) {

        // MODULE: TRIMMOMATIC
        TRIMMOMATIC(
            ch_reads
        )

        // MODULE: FASTQC_VANILLA
        FASTQC_VANILLA (
            TRIMMOMATIC.out.trimmed_reads
        )
    }
}
