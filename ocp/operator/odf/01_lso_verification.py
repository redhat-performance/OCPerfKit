import subprocess
import time

def check_pod():
    while True:
        result = subprocess.run(
            ["oc", "get", "pod", "-n", "openshift-local-storage"],
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            universal_newlines=True
        )
        if "local-storage-operator" in result.stdout:
            print("Resource found!")
            break
        else:
            print("Resource not found, checking again in 10 seconds...")
            time.sleep(10)

if __name__ == "__main__":
    check_pod()

