On Windows:-
1. ./packer.exe build --force k8s.pkr.hcl
2. ./packer.exe validate k8s.pkr.hcl
On Linux:-
Note: Make sure ../package_downloader/packages have all the k8s rpm downloaded.
packer build --force k8s.pkr.hcl

After Packer Created Box successfully:-
1. Upload the box to vagrant cloud.
2. Start creating k8s cluster with this packer created box.


