##################
# Key generation #
##################

# Generate a new key pair
# This .pem file contains the private key and should never, ever be shared.
# Note that it also contains the public key, which needs to be extracted
openssl genrsa -out private.pem

# View contents of private key in human-readable format
openssl rsa -text -in private.pem

# Extract public key
openssl rsa -in private.pem -outform PEM -pubout -out public.pem

# View contents of public key in human-readable format
openssl rsa -text -pubin -in public.pem

#############################
# Encryption and decryption #
#############################

# Encrypt a message (using the public key)
openssl pkeyutl -encrypt -pubin -inkey public.pem -in message.txt -out
message_encrypted.ssl

# Decrypt a message (using the private key)
openssl pkeyutl -decrypt -inkey private.pem -in message_encrypted

################################
# Signatures and verifications #
################################

# Sign a message (using the private key)
openssl dgst -sha256 -sign private.pem -out message.txt.signature message.txt

# Verify a signature
openssl dgst -sha256 -verify public.pem -signature message.txt.signature data.txt

################
# Certificates #
################

# Prepare a certificate request
openssl req -new -key private.pem -out certificate.csr

# View certificate request contents in human-readable format
openssl req -text -noout -verify -in certificate.csr

# A certificate request is the file that needs to be sent to a certificate
# authority to obtain a certificate.
# The certificate authority will first verify the request's signature using our
# public key.
# Then they will perform extra checks (for example asking for a specific TXT DNS
# record to be added on the domain if the certificate is for a website).
# Finally the certificate authority issues the certificate which is signed with
# their private key. Their public key can be used to verify the signature and 
# therefore the authenticity of the certificate.

# View the contents of a certificate
openssl x509 -in cert.pem -text -noout
