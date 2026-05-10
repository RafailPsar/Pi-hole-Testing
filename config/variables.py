import os
from dotenv import load_dotenv

# Automatically load variables from the .env file
load_dotenv()

# Expose variables to Robot Framework
PIHOLE_URL = os.getenv("PIHOLE_URL")
PIHOLE_PASSWORD = os.getenv("PIHOLE_PASSWORD")

# Fail-safe check
if not PIHOLE_URL:
    raise ValueError("WARNING: PIHOLE_URL is not set! Did you forget to create the .env file from .env.example?")