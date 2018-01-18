	result, err := awsc.DescribeInstancesWithEBS()
	var devIDs []string
	for _, resvr := range result.Reservations {
		for _, inst := range resvr.Instances {
			for _, dev := range inst.BlockDeviceMappings {
				devIDs = append(devIDs, *dev.Ebs.VolumeId)
			}
		}
	}