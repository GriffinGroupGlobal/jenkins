#!groovy

import jenkins.model.*
import hudson.security.*
import jenkins.security.s2m.AdminWhitelistRule

// https://github.com/geerlingguy/ansible-role-jenkins/blob/master/templates/basic-security.groovy
// https://technologyconversations.com/2017/06/16/automating-jenkins-docker-setup/

def instance = Jenkins.getInstance()

def user = "{{ user }}"
def pass = "{{ password }}"

def hudsonRealm = new HudsonPrivateSecurityRealm(false)
hudsonRealm.createAccount(user, pass)
instance.setSecurityRealm(hudsonRealm)

def strategy = new FullControlOnceLoggedInAuthorizationStrategy()
instance.setAuthorizationStrategy(strategy)
instance.save()

Jenkins.instance.getInjector().getInstance(AdminWhitelistRule.class).setMasterKillSwitch(false)
