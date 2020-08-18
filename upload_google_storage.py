#!/usr/bin/env python3

# Upload a directory (recursively, all files and subfolders) to a Google
# Storage bucket. The environment variable GOOGLE_APPLICATION_CREDENTIALS
# is required, along with the google-cloud-storage library. This script is
# intended to upload the testing data in data/ to a user bucket to test
# the Google Life Sciences tutorial. Intended/expected usage is:
#
# python upload_google_storage.py <bucket>/<subpath> <folder>
# python upload_google_storage.py snakemake-testing-data/ data/
#
# The above would upload data from data/ locally to the root of the bucket.

import argparse
import glob
import os
import sys

try:
    from google.cloud import storage
except ImportError:
    sys.exit("Please pip install google-cloud-storage")


# Check that google application credentials are exported
if not os.environ.get("GOOGLE_APPLICATION_CREDENTIALS"):
    sys.exit("Please export GOOGLE_APPLICATION_CREDENTIALS for your project")


def get_parser():
    parser = argparse.ArgumentParser(description="Google Storage Uploader")

    parser.add_argument(
        "bucket",
        help="The name of the bucket and subfolder to upload to (e.g., snakemake-testing/1)",
    )

    parser.add_argument(
        "path", help="the folder or file path to (recursively) upload content.",
    )

    return parser


def confirm():
    """Ask the user if he/she would like to proceed. Returns True/False.
    """
    while True:
        ans = input("\nWould you like to proceed? [y]|n: ")
        if not ans:
            return False
        if ans not in ["y", "Y", "n", "N"]:
            print("please enter y or n.")
            continue
        if ans == "y" or ans == "Y":
            return True
        if ans == "n" or ans == "N":
            return False


def add_ending_slash(filename):
    """Since we want to replace based on having an ending slash, ensure it's there
    """
    if not filename.endswith("/"):
        filename = "%s/" % filename
    return filename


def main():
    """upload one or more files to Google Cloud Storage, relative to the
       present working directory.
    """

    parser = get_parser()

    # If an error occurs while parsing the arguments, the interpreter will exit with value 2
    args, extra = parser.parse_known_args()

    client = storage.Client()
    here = os.path.dirname(os.path.abspath(__file__))
    bucket_name = args.bucket.split("/")[0]

    print(f"Attempting to get or create bucket {bucket_name}")

    try:
        bucket = client.get_bucket(bucket_name)
    except:
        bucket = client.create_bucket(bucket_name)

    print(f"Obtained bucket {bucket}")

    # Ensure we have relative path to bucket
    args.bucket = add_ending_slash(args.bucket)
    bucket_path = args.bucket.replace(bucket_name + "/", "", 1)

    print("\nThe following files will be uploaded:")

    # key, full path, value: upload path in storage
    filenames = {}
    for x in os.walk(args.path):
        for name in glob.glob(os.path.join(x[0], "*")):
            if not os.path.isdir(name):

                # Replace the present working directory and path
                storage_path = name.replace(here + os.path.sep, "")

                # Ensure we have relative path
                prefix = add_ending_slash(args.path)
                storage_path = storage_path.replace(prefix, "")
                filenames[name] = os.path.join(bucket_path, storage_path)
                full_path = os.path.join(bucket_name, bucket_path, storage_path)
                print(f"{name} -> {full_path}")

    if not confirm():
        sys.exit(0)

    # Upload files in script and base gooogle life sciences folder
    for local, remote in filenames.items():
        blob = bucket.blob(remote)
        if not blob.exists():
            print("Uploading %s to %s" % (remote, bucket_name))
            blob.upload_from_filename(local)


if __name__ == "__main__":
    main()
