file=$1
for i in "proportion_earned" "blocks_per_minute" "system_blocks_per_minute"; do
	paste ${file}${i}_0.0.data ${file}${i}_0.5.data ${file}${i}_1.0.data | awk '{print $1, $2, $3, $6, $7, $10, $11, $12}' > ${file}${i}.data
	head ${file}${i}.data
done
