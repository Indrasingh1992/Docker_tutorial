import boto3

# ✏️ 1.  Paste YOUR keys here
AWS_ACCESS_KEY_ID     = "AKIAYKFQRBVS6S5AAGDL"
AWS_SECRET_ACCESS_KEY = "YhFQxoyiqFHjawEEkUHw4snd5EH12uGTaiVtqjua"

# 2.  Create a session in your preferred Region
session = boto3.Session(
    aws_access_key_id     = AWS_ACCESS_KEY_ID,
    aws_secret_access_key = AWS_SECRET_ACCESS_KEY,
    region_name           = "us-east-1"    # Virginia (change if needed)
)

# 3.  Example call: list all EC2 instance IDs & states
ec2 = session.client("ec2")

# resp = ec2.describe_instances()
# print(resp)
# for r in resp["Reservations"]:
#     for inst in r["Instances"]:
#         print(inst)

for instance in ec2.instances.all():
    print(
        instance.id,                      # i-0123456789abcdef0
        instance.instance_type,           # t3.micro
        instance.state["Name"],           # running | stopped | ...
        instance.public_ip_address or "-" # may be None
    )
