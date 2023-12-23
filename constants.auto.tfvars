organization = "eggs-projects"

environments = {
  "dev" = {
    "hosted_zone" = "mikeeggers.com"
    "account_id"  = "470292911211"
    "eks_cluster" = {
      "enabled" = true
    }
  }
  "prod" = {
    "hosted_zone" = "michaeldeggers.com"
    "account_id"  = "174199678932"
    "eks_cluster" = {
      "enabled" = false
    }
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
    "prod_enabled" : true
  },
  "eks-cluster" = {
    "description" : "EKS Configuration for hosting Projects",
    "tags" : ["project"],
    "visibility" : "public",
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
    "template" : {
      "owner" : "michaeldeggers",
      "repo" : "repo_template"
    },
    "prod_enabled" : false
  }
}
