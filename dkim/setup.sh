# Create a TXT record with the public key:
# Host : at._domainkey.alpchemist.com
# TXT Value: v=DKIM1; k=rsa; t=s; p=MIG....
#
# dkim: [
#    s: "at",
#    d: "alpchemist.com",
#    private_key: {:pem_plain, File.read!("/app/private-key.pem")}
# ]
#
openssl genrsa -out private-key.pem 1024
openssl rsa -in private-key.pem -out public-key.pem -pubout