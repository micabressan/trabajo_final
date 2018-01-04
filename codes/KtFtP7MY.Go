func ExtractErf(module *erf.ERF, destinationPath string) {
	err := createDirectory(destinationPath)

	if err != nil {
		fmt.Println(err.Error())

		return
	}

	var resourceDataOffset = module.Header.OffsetToResourceList + module.Header.EntryCount*8

	for index, key := range module.KeyList {
		var fileName = destinationPath + string(os.PathSeparator) + key.ResRef + "." + file.ResourceTypeLookup[key.ResType]
		var listElement = module.ResourceList[index]
		var offset = listElement.OffsetToResource - resourceDataOffset

		fmt.Println(fmt.Sprintf("Offset: %010d; File size: %010d bytes; File name: %s", offset, listElement.ResourceSize, fileName))
		var fileContent = module.ResourceData[offset : offset+listElement.ResourceSize-1]
		tools.EasyPanic(ioutil.WriteFile(fileName, fileContent, os.FileMode(0644))) // this panics
	}
}

/*
Console output:

Offset: 0000000000; File size: 0000012937 bytes; File name: extracted/barrowsinterior8.are
Offset: 0000012937; File size: 0000000472 bytes; File name: extracted/barrowsinterior8.gic
Offset: 0000013409; File size: 0000010393 bytes; File name: extracted/barrowsinterior8.git
Offset: 0000023802; File size: 0000019273 bytes; File name: extracted/beholdercaves10x.are
Offset: 0000043075; File size: 0000000392 bytes; File name: extracted/beholdercaves10x.gic
Offset: 0000043467; File size: 0000000724 bytes; File name: extracted/beholdercaves10x.git
Offset: 0000044191; File size: 0000003064 bytes; File name: extracted/creaturepalcus.itp
panic: open extracted/creaturepalcus.itp: invalid argument

goroutine 1 [running]:
aurora/tools.EasyPanic(0x554260, 0xc42008e0c0)
	/home/elegos/Development/nwn-toolset-go/src/aurora/tools/easyPanic.go:6 +0x4a
cli/command.ExtractErf(0xc42004be58, 0x7ffc4940fd53, 0x9)
	/home/elegos/Development/nwn-toolset-go/src/cli/command/extract.go:60 +0xf8
main.main()
	/home/elegos/Development/nwn-toolset-go/src/cli/main.go:25 +0x16b

*/