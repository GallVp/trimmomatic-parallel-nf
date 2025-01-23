# trimmomatic-parallel-nf

A Nextflow pipeline to run test run Trimmomatic split -> trim -> merge approach for greater parallel performance

## Run

```bash
nextflow run gallvp/trimmomatic-parallel-nf \
    -revision <revision> \
    -profile <docker,singularity,...> \
    --reads_1 reads_R1.fq.gz \
    --reads_2 reads_R2.fq.gz \
    --outdir <OUTDIR>
```
