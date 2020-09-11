# Example data for the Snakemake tutorial

This repository hosts the data needed for the [Snakemake tutorial](https://snakemake.readthedocs.io/en/stable/tutorial/tutorial.html).

## Uploaders

### Google Cloud Storage

If you want to upload the data to Google Cloud Storage, you should first
export your `GOOGLE_APPLICATION_CREDENTIALS` for your project:

```bash
export GOOGLE_APPLICATION_CREDENTIALS=/path/to/credentials.json
```

And install the google-cloud-storage client:

```bsah
pip install google-cloud-storage
```

You can then use [upload_google_storage.py](upload_google_storage.py) to specify a bucket name
(and an optional subfolder in the bucket) to upload the content of [data](data)
to your bucket. The script takes (as the first argument) the bucket name plus path
(e.g., `<bucket>/<subfolder>` followed by the local directory path to upload.
The path that you provide (e.g., `data/`) will be removed from the storage path.
As an example:

```bash
python upload_google_storage.py <bucket>/<subpath> <folder>
```

would be used like:

```bash
python upload_google_storage.py snakemake-testing-data/ data/
```

And it would upload the contents of data (without the data/ prefix) to 
the root of the bucket snakemake-testing-data, which does not need to exist,
but you need to have permissions via your Google application credentials
to create or otherwise interact with it. Here is an example of the client 
running. Note that it asks for confirmation (y/n) to proceed with the upload:

```bash
$ python upload_google_storage.py snakemake-testing-data/ data
Attempting to get or create bucket snakemake-testing-data
Obtained bucket <Bucket: snakemake-testing-data>

The following files will be uploaded:
data/genome.fa.pac -> snakemake-testing-data/genome.fa.pac
data/genome.fa.fai -> snakemake-testing-data/genome.fa.fai
data/genome.fa.ann -> snakemake-testing-data/genome.fa.ann
data/genome.fa.bwt -> snakemake-testing-data/genome.fa.bwt
data/genome.fa.sa -> snakemake-testing-data/genome.fa.sa
data/genome.fa -> snakemake-testing-data/genome.fa
data/genome.fa.amb -> snakemake-testing-data/genome.fa.amb
data/samples/B.fastq -> snakemake-testing-data/samples/B.fastq
data/samples/A.fastq -> snakemake-testing-data/samples/A.fastq
data/samples/C.fastq -> snakemake-testing-data/samples/C.fastq

Would you like to proceed? [y]|n: y
Uploading genome.fa.pac to snakemake-testing-data
Uploading genome.fa.fai to snakemake-testing-data
Uploading genome.fa.ann to snakemake-testing-data
Uploading genome.fa.bwt to snakemake-testing-data
Uploading genome.fa.sa to snakemake-testing-data
Uploading genome.fa to snakemake-testing-data
Uploading genome.fa.amb to snakemake-testing-data
Uploading samples/B.fastq to snakemake-testing-data
Uploading samples/A.fastq to snakemake-testing-data
Uploading samples/C.fastq to snakemake-testing-data
```

You should then be able to see your files in Storage! Good job!

![.aux/upload-google-storage.png](.aux/upload-google-storage.png)

