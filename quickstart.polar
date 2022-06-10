# declare User
actor User {}

# declare Organization
resource Organization {
  permissions = ["read"];
  roles = ["owner"];

  # if actor owns organization, is allowed to read organization
  # this is shorthand. to learn more, see https://cloud-docs.osohq.com/reference/resource-blocks#shorthand-rules
  "read" if "owner";
}

# declare Repository
resource Repository {
  permissions = ["push"];
  roles = ["maintainer"];
  relations = { parent: Organization };

  # if actor owns organization, is also a maintainer of its repositories
  "maintainer" if "owner" on "parent";
  "push" if "maintainer";
}

# declare Wallet
resource Wallet {
  permissions = ["spend"];
  roles = ["owner"];

  # if actor owns wallet, is allowed to spend
  "spend" if "owner";
}

