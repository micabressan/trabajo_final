def put_alarm
  name = "metric_alarm_up_#{Time.now.to_i}"
  policy_up_arn = "arn:aws:autoscaling:eu-west-1:175763612495:scalingPolicy:b85f94a7-ea3e-458c-a9ec-cb1781f43950:autoScalingGroupName/auto_scaling_group_20111003-102345:policyName/auto_scaling_policy_20111003-10234$
  groupname = "auto_scaling_group_20111003-102345"

  cw = Fog::AWS::CloudWatch.new(fog_config)
  res = cw.put_metric_alarm(name, { "Alarm" => [policy_up_arn] },
                            "MetricName" => "CPUUtilization",
                            "Namespace" => "AWS/EC2",
                            "Statistic" => "Average",
                            "Unit" => "Percent",
                            "ComparisonOperator" => "GreaterThanThreshold",
                            "Period" => 60,
                            "EvaluationPeriods" => 2,
                            "Threshold" => 75,
                            "Dimensions" => [{ "Name" => "AutoScalingGroupName",
                                               "Value" => groupname }]
                            )
  pp res
end