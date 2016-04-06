type RpmPackage struct {

    Package string  `xml:package`
    Type string `xml:"type"`
    Name string `xml:"name"`
    Architecture string `xml:"arch"`
    PackageVersionField PackageVersionField `xml:"version"`
    PackageChecksumField PackageChecksumField `xml:"checksum"`
    Summary string `xml:"summary"`
    Description string `xml:"description"`
    Packager string `xml:"packager"`
    Url string `xml:"url"`
    PackageTimeField PackageTimeField `xml:"time"`
    PackageSizeField PackageSizeField `xml:"size"`
    LocationHref string `xml:"href,attr"` 
    // RpmRelationField
    RpmFormatField RpmFormatField `xml:"format"`

}

type RpmMetadata struct {

     Metadata xml.Name `xml:"Metadata"`
     XmlNS string `xml:"xmlns,attr"`
     XmlNsSuSE string `xml:"xmlns:suse,attr"`
     XmlNsRpm string `xml:"xmlns:rpm,attr"`
     PackagesCount string `xml:"packages,attr"`
     RpmPackages []RpmPackage `xml:"metadata>package"`

}

type PackageVersionField struct{

    Epoch string `xml:"epoch,attr"`
    Ver string `xml:"ver,attr"`
    Rel string `xml:"rel,attr"`

}

type PackageChecksumField struct{


    Checksum string `xml:",chardata"`
    Type string `xml:"type,attr"`
    Pkgid string `xml:"pkgid,attr"`

}

type PackageTimeField struct{

    File string `xml:"file,attr"`
    Build string `xml:"build,attr"`

}

type PackageSizeField struct {

    Package string `xml:"package,attr"`
    Installed string `xml:"installed,attr"`
    Archive string `xml:"archive,attr"`



}



type RpmEntryField struct {

    Name string `xml:"name,attr"`
    Flags string `xml:"flags,attr"`
    Epoch string `xml:"epoch,attr"`
    Ver string `xml:"ver,attr"`
    Rel string `xml:"rel,attr"`

}

type RpmFormatField struct {

    License string `xml:"license,attr"`
    Vendor string `xml:"vendor,attr"`
    Group string `xml:"group,attr"`
    Buildhost string `xml:"buildhost,attr"`
    SourceRpm string `xml:"sourcerpm,attr"`
    RpmFormatHeaderRangeField RpmFormatHeaderRangeField `xml:"header-range"` 
    RpmProvidesField []RpmEntryField `xml:"rpm:provides>rpm:entry"`
    RpmRequiresField []RpmEntryField `xml:"rpm:requires>rpm:entry"`

}

type RpmFormatHeaderRangeField struct {

    Start string `xml:"start,attr"`
    End string `xml:"end,attr"`

}