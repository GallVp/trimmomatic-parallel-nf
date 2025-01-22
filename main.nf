#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { TRIMMOMATIC_PE } from "./modules/custom/trimmomatic_pe/main.nf"
include { TRIMMOMATIC } from "./modules/nf-core/trimmomatic/main.nf"

workflow  {
    TRIMMOMATIC_PARALLEL_NF()
}

workflow TRIMMOMATIC_PARALLEL_NF {

    ch_reads = Channel.of(
        [
            [
                id: file(params.reads_1).simpleName,
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

    // MODULE: TRIMMOMATIC
    TRIMMOMATIC(
        ch_reads
    )
}
