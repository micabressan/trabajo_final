apply plugin: 'java'

repositories {
    jcenter()
    mavenCentral()
}

configurations.all {
  resolutionStrategy {
    force 'org.eclipse.scout.sdk.deps:org.eclipse.core.runtime:3.12.0.v20160606-1342'
    force 'org.eclipse.scout.sdk.deps:org.eclipse.core.jobs:3.8.0.v20160509-0411'
    force 'org.eclipse.scout.sdk.deps:org.eclipse.equinox.preferences:3.6.0.v20160120-1756'
    force 'org.eclipse.scout.sdk.deps:org.eclipse.equinox.registry:3.6.100.v20160223-2218'
    force 'org.eclipse.scout.sdk.deps:org.eclipse.core.contenttype:3.5.100.v20160418-1621'
    force 'org.eclipse.scout.sdk.deps:org.eclipse.core.runtime:3.12.0.v20160606-1342'
    force 'org.eclipse.scout.sdk.deps:org.eclipse.equinox.common:3.8.0.v20160509-1230'
    force 'org.eclipse.scout.sdk.deps:org.eclipse.core.expressions:3.5.100.v20160418-1621'
    force 'org.eclipse.scout.sdk.deps:org.eclipse.osgi:3.11.0.v20160603-1336'
    force 'org.eclipse.scout.sdk.deps:org.eclipse.core.filesystem:1.6.0.v20160503-1608'
    force 'org.eclipse.scout.sdk.deps:org.eclipse.core.resources:3.11.0.v20160503-1608'
  }
}

dependencies {
    compile('org.eclipse.birt.runtime:org.eclipse.birt.runtime:4.6.0-20160607') {
        exclude(module:'org.apache.poi')
        exclude(group: 'org.eclipse.birt.runtime', module: 'org.eclipse.orbit.mongodb')
        exclude(group: 'org.eclipse.scout.sdk.deps', module: 'org.eclipse.osgi')
        exclude(group: 'org.eclipse.scout.sdk.deps', module: 'org.eclipse.equinox.common')
        exclude(group: 'org.eclipse.scout.sdk.deps', module: 'org.eclipse.core.jobs')
        exclude(group: 'org.eclipse.scout.sdk.deps', module: 'org.eclipse.equinox.registry')
        exclude(group: 'org.eclipse.scout.sdk.deps', module: 'org.eclipse.equinox.preferences')
        exclude(group: 'org.eclipse.scout.sdk.deps', module: 'org.eclipse.core.contenttype')
        exclude(group: 'org.eclipse.scout.sdk.deps', module: 'org.eclipse.core.runtime')
        exclude(group: 'org.eclipse.scout.sdk.deps', module: 'org.eclipse.core.expressions')
        exclude(group: 'org.eclipse.scout.sdk.deps', module: 'org.eclipse.core.filesystem')
        transitive = false
        //compile group: 'org.eclipse.scout.sdk.deps', name: 'org.eclipse.core.runtime', version: '3.12.0.v20160606-1342'
    }

    compile('org.eclipse.scout.sdk.deps:org.eclipse.core.runtime:3.12.0.v20160606-1342')
    compile('org.eclipse.scout.sdk.deps:org.eclipse.equinox.preferences:3.6.0.v20160120-1756')
    compile('org.eclipse.scout.sdk.deps:org.eclipse.equinox.registry:3.6.100.v20160223-2218')
    compile('org.eclipse.scout.sdk.deps:org.eclipse.core.contenttype:3.5.100.v20160418-1621')
    compile('org.eclipse.scout.sdk.deps:org.eclipse.core.runtime:3.12.0.v20160606-1342')
    compile('org.eclipse.scout.sdk.deps:org.eclipse.equinox.common:3.8.0.v20160509-1230')
    compile('org.eclipse.scout.sdk.deps:org.eclipse.core.expressions:3.5.100.v20160418-1621')
    compile('org.eclipse.scout.sdk.deps:org.eclipse.osgi:3.11.0.v20160603-1336')
    compile('org.eclipse.scout.sdk.deps:org.eclipse.core.filesystem:1.6.0.v20160503-1608')
    compile('org.eclipse.scout.sdk.deps:org.eclipse.core.resources:3.11.0.v20160503-1608')
}