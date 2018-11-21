# To upgrade an existing install

    salt '<kms-servers>' state.apply vlmcsd pillar='{"vlmcsd": {"upgrade": True}}'
