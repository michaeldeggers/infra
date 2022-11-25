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
    "template" : {
      "owner" : "michaeldeggers",
      "repo" : "repo_template"
    },
    "tfe" : {
      "environments" : ["dev"]
    }
  },
  "gatsby-blog" = {
    "description" : "Blog to track projects, gaming, opinions, etc...",
    "tags" : ["project"],
    "visibility" : "public",
    "template" : {
      "owner" : "michaeldeggers",
      "repo" : "starter-gatsby-blog"
    },
    "tfe" : {
      "environments" : ["dev"]
    }
  },
  "test-repo" = {
    "description" : "Test Repo",
    "tags" : ["demo"],
    "visibility" : "private",
    "template" : {
      "owner" : "michaeldeggers",
      "repo" : "repo_template"
    },
    "tfe" : {
      "environments" : ["dev"]
    }
  }
}
