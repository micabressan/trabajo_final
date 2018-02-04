@Unroll
def "Method setGateway calculates gateway and put it with key GATEWAY_ENV_ATTR"() {
    when:
    def environment = ["Role": role, "BundleName": bundle, "ApplicationType": appType, "DeviceType": deviceType]
    SessionService.setGateway(environment)
    then:
    environment["Gateway"] == gateway
    where:
    role           | bundle | appType      | deviceType    | gateway
    "WEB_LIBERTEX" | null   | null         | null          | "WEB_LIBERTEX"
    "foo"          | null   | null         | null          | "foo"
    "WEB_LIBERTEX" | "foo"  | null         | null          | "MOBILE_LIBERTEX"
    null           | null   | null         | null          | "WEB_LIBERTEX"
    null           | null   | "wrapped"    | "SMART PHONE" | "MOBILE_LIBERTEX"
    null           | null   | "wrapped"    | "TABLET"      | "MOBILE_LIBERTEX"
    null           | null   | "wrapped"    | "foo"         | "WEB_LIBERTEX"
    null           | null   | "nmp"        | null          | "MOBILE_LIBERTEX"
    null           | null   | "nmp-web"    | null          | "MOBILE_LIBERTEX"
    null           | null   | "tablet"     | null          | "MOBILE_LIBERTEX"
    null           | null   | "tablet-web" | null          | "MOBILE_LIBERTEX"
    null           | "foo"  | "bar"        | null          | "MOBILE_LIBERTEX"
    null           | null   | "bar"        | null          | "WEB_LIBERTEX"
}