organization = "eggs-projects"

environments = {
  "dev" = {
    "hosted_zone" = "mikeeggers.com"
    "account_id"  = "470292911211"
  }
  "prod" = {
    "hosted_zone" = "michaeldeggers.com"
    "account_id"  = "174199678932"
  }
}

projects = {
  "ghost-blog" = {
    "description" : "Blog to track projects, gaming, opinions, etc...",
    "tags" : ["project"],
    "visibility" : "public",
    "advanced_security" : "enabled",               # enabled by default on all public repos
    "secret_scanning" : "enabled",                 # disabled - requires advanced feature purchase
    "secret_scanning_push_protection" : "enabled", # disabled - requires advanced feature purchase
    "template" : {
      "owner" : "michaeldeggers",
      "repo" : "repo_template"
    },
    "prod_enabled" : true
  },
  "test-repo" = {
    "description" : "Test Repo",
    "tags" : ["demo"],
    "visibility" : "private",
    "advanced_security" : "disabled",               # disabled - requires advanced feature purchase
    "secret_scanning" : "disabled",                 # disabled - requires advanced feature purchase
    "secret_scanning_push_protection" : "disabled", # disabled - requires advanced feature purchase
    "template" : {
      "owner" : "michaeldeggers",
      "repo" : "repo_template"
    },
    "prod_enabled" : false
  }
}
