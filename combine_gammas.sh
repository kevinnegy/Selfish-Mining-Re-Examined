file=$1
for j in "Selfish" "Honest"; do
	for i in "proportion_earned" "blocks_per_minute" "system_blocks_per_minute"; do
		paste ${file}${j}_${i}_0.0_add_hash.data ${file}${j}_${i}_0.5_add_hash.data ${file}${j}_${i}_1.0_add_hash.data | awk '{print $1, $2, $3, $6, $7, $10, $11, $12}' > ${file}${j}_${i}.data
		head ${file}${j}_${i}_add_hash.data
	done
done
