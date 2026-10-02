scores = { alice: 95, bob: 72, carol: 88, dave: 55 }
pass, fail = scores.partition { |_, score| score >= 80 }
# pass => {:alice=>95, :carol=>88}
# fail => {:bob=>72, :dave=>55}