# Assumes current directory has data files in ./data/ and will store graphs in ./graphs/
system "mkdir graphs"
set terminal pdf enhanced font ',19'; set size 1, 1


filename="BTC_IntermittentSelfish_blocks_per_minute"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Blocks/Minute' 
set xlabel 'BTC ISM {/Symbol a} (%)'
set xrange [0:50]; set xtics 0, 10, 50
set yrange [0:.1]
set key top
set key left
plot data using ($1*100):2 with lines lw 4 lc rgb "red" dashtype 2 title "{/Symbol g} = 0", data using ($1*100):4 with lines lw 4 lc rgb "green" dashtype 4 title "{/Symbol g} = 0.5", data using ($1*100):6 with lines lw 4 lc rgb "blue" dashtype 3 title "{/Symbol g} = 1", data using ($1*100):8 with lines lw 4 lc rgb "gray40" title "Honest"
set output

filename="BTC_IntermittentSelfish_proportion_earned"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Proportion earned' 
set xlabel 'BTC ISM {/Symbol a} (%)'
set yrange [0:1]
set key top
set key left
plot data using ($1*100):2 with lines lw 4 lc rgb "red" dashtype 2 title "{/Symbol g} = 0", data using ($1*100):4 with lines lw 4 lc rgb "green" dashtype 4 title "{/Symbol g} = 0.5", data using ($1*100):6 with lines lw 4 lc rgb "blue" dashtype 3 title "{/Symbol g} = 1", data using ($1*100):8 with lines lw 4 lc rgb "gray40" title "Honest"
set output

filename="BTC_IntermittentSelfish_timestep_target_block_time"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set yrange [0:*]
set xrange [0:16000]; set xtics 0, 4000, 16000
set key top
set key left
set ylabel 'Minutes' 
set xlabel 'BTC Timesteps (blocks mined)'
plot data using 1:($2 == -1 ? NaN : $2) with line lw 4 lc rgb "red" dashtype 2  title '{/Symbol a} = 10%', data using 1:($2 == -1 ? NaN : $2):($3 == -1 ? NaN : $3) every 2016 with errorbars lw 4 lc rgb "black" notitle, data using 1:($4 == -1 ? NaN : $4) with line lw 4 lc rgb "blue" dashtype 3  title '{/Symbol a} = 33%', data using 1:($4 == -1 ? NaN : $4):($5 == -1 ? NaN : $5) every 2016 with errorbars lw 4 lc rgb "black" notitle, data using 1:($6 == -1 ? NaN : $6) with line lw 4 lc rgb "green" dashtype 4  title '{/Symbol a} = 49%', data using 1:($6 == -1 ? NaN : $6):($7 == -1 ? NaN : $7) every 2016 with errorbars lw 4 lc rgb "black" notitle
set output

filename="BTC_IntermittentSelfish_timestep_diff"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Difficulty (10^{20})'
set yrange [0:40]
set xrange [0:12000]; set xtics 0, 4000, 12000
set key bottom left
set xlabel 'BTC Timesteps (blocks mined)'
plot data using 1:($2 == -1 ? NaN : ($2/1.0e20)) with line lw 4 lc rgb "red" dashtype 2  title '{/Symbol a} = 10%', data using 1:($4 == -1 ? NaN : ($4/1.0e20)) with line lw 4 lc rgb "blue" dashtype 3  title '{/Symbol a} = 33%', data using 1:($6 == -1 ? NaN : ($6/1.0e20)) with line lw 4 lc rgb "green" dashtype 4  title '{/Symbol a} = 49%'
set output

filename="BTC_IntermittentSelfish_timestep_profit_blocks_per_minute"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Blocks/Minute' 
set yrange [0:0.1]
set xrange [0:12000]; set xtics 0, 4000, 12000
set key top right
set xlabel 'BTC Timesteps (blocks mined)'
plot data using 1:($2 == -1 ? NaN : $2) with line lw 4 lc rgb "red" dashtype 2  title '{/Symbol a} = 10%', data using 1:($2 == -1 ? NaN : $2):($3 == -1 ? NaN : $3) every 2016 with errorbars lw 4 lc rgb "black" notitle, data using 1:($4 == -1 ? NaN : $4) with line lw 4 lc rgb "blue" dashtype 3  title '{/Symbol a} = 33%', data using 1:($4 == -1 ? NaN : $4):($5 == -1 ? NaN : $5) every 2016 with errorbars lw 4 lc rgb "black" notitle, data using 1:($6 == -1 ? NaN : $6) with line lw 4 lc rgb "green" dashtype 4  title '{/Symbol a} = 49%', data using 1:($6 == -1 ? NaN : $6):($7 == -1 ? NaN : $7) every 2016 with errorbars lw 4 lc rgb "black" notitle
set output

filename="BTC_IntermittentSelfish_system_blocks_per_minute"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Blocks/Minute'
set xlabel 'BTC ISM {/Symbol a} (%)'
set yrange [0:0.15]
set xrange[0:50]; set xtics 0, 10, 50
set key bottom 
set key left
plot data using ($1*100):2 with lines  lw 4 lc rgb "red" dashtype 2 title "{/Symbol g} = 0", data using ($1*100):4 with lines  lw 4 lc rgb "green" dashtype 4 title "{/Symbol g} = 0.5", data using ($1*100):6 with lines  lw 4 lc rgb "blue" dashtype 3 title "{/Symbol g} = 1", data using ($1*100):8 with lines  lw 4 lc rgb "gray40" title "Honest"
set output

filename="BTC_Honest_blocks_per_minute_add_hash"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Blocks/Minute' 
set xlabel 'BTC Honest {/Symbol a} (%)'
set xrange [0:50]; set xtics 0, 10, 50
set yrange [0:.1]
set key top
set key left
plot data using ($1*100):2 with lines lw 4 lc rgb "red" dashtype 2 title "{/Symbol g} = 0", data using ($1*100):4 with lines lw 4 lc rgb "green" dashtype 4 title "{/Symbol g} = 0.5", data using ($1*100):6 with lines lw 4 lc rgb "blue" dashtype 3 title "{/Symbol g} = 1", data using ($1*100):8 with lines lw 4 lc rgb "gray40" title "Honest"
set output

filename="BTC_Selfish_blocks_per_minute_add_hash"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Blocks/Minute' 
set xlabel 'BTC Selfish {/Symbol a} (%)'
set xrange [0:50]; set xtics 0, 10, 50
set yrange [0:.1]
set key top
set key left
plot data using ($1*100):2 with lines lw 4 lc rgb "red" dashtype 2 title "{/Symbol g} = 0", data using ($1*100):4 with lines lw 4 lc rgb "green" dashtype 4 title "{/Symbol g} = 0.5", data using ($1*100):6 with lines lw 4 lc rgb "blue" dashtype 3 title "{/Symbol g} = 1", data using ($1*100):8 with lines lw 4 lc rgb "gray40" title "Honest"
set output

filename="BTC_Selfish_proportion_earned_add_hash"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Proportion earned' 
set xlabel 'BTC Selfish {/Symbol a} (%)'
set yrange [0:1]
set key top
set key left
plot data using ($1*100):2 with lines lw 4 lc rgb "red" dashtype 2 title "{/Symbol g} = 0", data using ($1*100):4 with lines lw 4 lc rgb "green" dashtype 4 title "{/Symbol g} = 0.5", data using ($1*100):6 with lines lw 4 lc rgb "blue" dashtype 3 title "{/Symbol g} = 1", data using ($1*100):8 with lines lw 4 lc rgb "gray40" title "Honest"
set output

filename="BTC_Honest_proportion_earned_add_hash"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Proportion earned' 
set xlabel 'BTC Honest {/Symbol a} (%)'
set yrange [0:1]
set key top
set key left
plot data using ($1*100):2 with lines lw 4 lc rgb "red" dashtype 2 title "{/Symbol g} = 0", data using ($1*100):4 with lines lw 4 lc rgb "green" dashtype 4 title "{/Symbol g} = 0.5", data using ($1*100):6 with lines lw 4 lc rgb "blue" dashtype 3 title "{/Symbol g} = 1", data using ($1*100):8 with lines lw 4 lc rgb "gray40" title "Honest"
set output

filename="BTC_Selfish_timestep_target_block_time_add_hash"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set yrange [0:*]
set xrange [0:16000]; set xtics 0, 4000, 16000
set key bottom right
set ylabel 'Minutes' 
set xlabel 'BTC Timesteps (blocks mined)'
plot data using 1:($2 == -1 ? NaN : $2) with line lw 4 lc rgb "red" dashtype 2  title '{/Symbol a} = 10%', data using 1:($2 == -1 ? NaN : $2):($3 == -1 ? NaN : $3) every 2016 with errorbars lw 4 lc rgb "black" notitle, data using 1:($4 == -1 ? NaN : $4) with line lw 4 lc rgb "blue" dashtype 3  title '{/Symbol a} = 33%', data using 1:($4 == -1 ? NaN : $4):($5 == -1 ? NaN : $5) every 2016 with errorbars lw 4 lc rgb "black" notitle, data using 1:($6 == -1 ? NaN : $6) with line lw 4 lc rgb "green" dashtype 4  title '{/Symbol a} = 49%', data using 1:($6 == -1 ? NaN : $6):($7 == -1 ? NaN : $7) every 2016 with errorbars lw 4 lc rgb "black" notitle
set output

filename="BTC_Honest_timestep_target_block_time_add_hash"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Minutes' 
set yrange [0:*]
set xrange [0:8064]; set xtics 0, 2000, 8064
set key bottom right
set xlabel 'BTC Timesteps (blocks mined)'
plot data using 1:($2 == -1 ? NaN : $2) with line lw 4 lc rgb "red" dashtype 2  title '{/Symbol a} = 10%', data using 1:($2 == -1 ? NaN : $2):($3 == -1 ? NaN : $3) every 2016 with errorbars lw 4 lc rgb "black" notitle, data using 1:($4 == -1 ? NaN : $4) with line lw 4 lc rgb "blue" dashtype 3  title '{/Symbol a} = 33%', data using 1:($4 == -1 ? NaN : $4):($5 == -1 ? NaN : $5) every 2016 with errorbars lw 4 lc rgb "black" notitle, data using 1:($6 == -1 ? NaN : $6) with line lw 4 lc rgb "green" dashtype 4  title '{/Symbol a} = 49%', data using 1:($6 == -1 ? NaN : $6):($7 == -1 ? NaN : $7) every 2016 with errorbars lw 4 lc rgb "black" notitle
set output

filename="BTC_Selfish_timestep_diff_add_hash"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Difficulty (10^{20})'
set yrange [0:70]
set xrange [0:16000]; set xtics 0, 4000, 16000
set key bottom left
set xlabel 'BTC Timesteps (blocks mined)'
plot data using 1:($2 == -1 ? NaN : ($2/1.0e20)) with line lw 4 lc rgb "red" dashtype 2  title '{/Symbol a} = 10%', data using 1:($4 == -1 ? NaN : ($4/1.0e20)) with line lw 4 lc rgb "blue" dashtype 3  title '{/Symbol a} = 33%', data using 1:($6 == -1 ? NaN : ($6/1.0e20)) with line lw 4 lc rgb "green" dashtype 4  title '{/Symbol a} = 49%'
set output

filename="BTC_Honest_timestep_diff_add_hash"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Difficulty (10^{20})'
set yrange [0:70]
set xrange [0:8064]; set xtics 0, 2000, 8064
set key bottom left
set xlabel 'BTC Timesteps (blocks mined)'
plot data using 1:($2 == -1 ? NaN : ($2/1.0e20)) with line lw 4 lc rgb "red" dashtype 2  title '{/Symbol a} = 10%', data using 1:($4 == -1 ? NaN : ($4/1.0e20)) with line lw 4 lc rgb "blue" dashtype 3  title '{/Symbol a} = 33%', data using 1:($6 == -1 ? NaN : ($6/1.0e20)) with line lw 4 lc rgb "green" dashtype 4  title '{/Symbol a} = 49%'
set output

filename="BTC_Selfish_timestep_profit_blocks_per_minute_add_hash"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Blocks/Minute' 
set yrange [0:0.15]
set xrange [0:16000]; set xtics 0, 4000, 16000
set key top right
set xlabel 'BTC Timesteps (blocks mined)'
plot data using 1:($2 == -1 ? NaN : $2) with line lw 4 lc rgb "red" dashtype 2  title '{/Symbol a} = 10%', data using 1:($2 == -1 ? NaN : $2):($3 == -1 ? NaN : $3) every 2016 with errorbars lw 4 lc rgb "black" notitle, data using 1:($4 == -1 ? NaN : $4) with line lw 4 lc rgb "blue" dashtype 3  title '{/Symbol a} = 33%', data using 1:($4 == -1 ? NaN : $4):($5 == -1 ? NaN : $5) every 2016 with errorbars lw 4 lc rgb "black" notitle, data using 1:($6 == -1 ? NaN : $6) with line lw 4 lc rgb "green" dashtype 4  title '{/Symbol a} = 49%', data using 1:($6 == -1 ? NaN : $6):($7 == -1 ? NaN : $7) every 2016 with errorbars lw 4 lc rgb "black" notitle
set output

filename="BTC_Honest_timestep_profit_blocks_per_minute_add_hash"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Blocks/Minute' 
set yrange [0:0.15]
set xrange [0:8064]; set xtics 0, 2000, 8064
set xlabel 'BTC Timesteps (blocks mined)'
plot data using 1:($2 == -1 ? NaN : $2) with line lw 4 lc rgb "red" dashtype 2  title '{/Symbol a} = 10%', data using 1:($2 == -1 ? NaN : $2):($3 == -1 ? NaN : $3) every 2016 with errorbars lw 4 lc rgb "black" notitle, data using 1:($4 == -1 ? NaN : $4) with line lw 4 lc rgb "blue" dashtype 3  title '{/Symbol a} = 33%', data using 1:($4 == -1 ? NaN : $4):($5 == -1 ? NaN : $5) every 2016 with errorbars lw 4 lc rgb "black" notitle, data using 1:($6 == -1 ? NaN : $6) with line lw 4 lc rgb "green" dashtype 4  title '{/Symbol a} = 49%', data using 1:($6 == -1 ? NaN : $6):($7 == -1 ? NaN : $7) every 2016 with errorbars lw 4 lc rgb "black" notitle
set output

filename="BSV_Honest_blocks_per_minute_add_hash"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Blocks/Minute' 
set xlabel 'BCH/BSV Honest {/Symbol a} (%)'
set xrange [0:50]; set xtics 0, 10, 50
set yrange [0:.1]
set key top
set key left
plot data using ($1*100):2 with lines lw 4 lc rgb "red" dashtype 2 title "{/Symbol g} = 0", data using ($1*100):4 with lines lw 4 lc rgb "green" dashtype 4 title "{/Symbol g} = 0.5", data using ($1*100):6 with lines lw 4 lc rgb "blue" dashtype 3 title "{/Symbol g} = 1", data using ($1*100):8 with lines lw 4 lc rgb "gray40" title "Honest"
set output

filename="BSV_Selfish_blocks_per_minute_add_hash"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Blocks/Minute' 
set xlabel 'BCH/BSV Selfish {/Symbol a} (%)'
set xrange [0:50]; set xtics 0, 10, 50
set yrange [0:.1]
set key top
set key left
plot data using ($1*100):2 with lines lw 4 lc rgb "red" dashtype 2 title "{/Symbol g} = 0", data using ($1*100):4 with lines lw 4 lc rgb "green" dashtype 4 title "{/Symbol g} = 0.5", data using ($1*100):6 with lines lw 4 lc rgb "blue" dashtype 3 title "{/Symbol g} = 1", data using ($1*100):8 with lines lw 4 lc rgb "gray40" title "Honest"
set output

filename="BSV_Selfish_proportion_earned_add_hash"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Proportion earned'  
set xlabel 'BCH/BSV Selfish {/Symbol a} (%)'
set yrange [0:1]
set key top
set key left
plot data using ($1*100):2 with lines lw 4 lc rgb "red" dashtype 2 title "{/Symbol g} = 0", data using ($1*100):4 with lines lw 4 lc rgb "green" dashtype 4 title "{/Symbol g} = 0.5", data using ($1*100):6 with lines lw 4 lc rgb "blue" dashtype 3 title "{/Symbol g} = 1", data using ($1*100):8 with lines lw 4 lc rgb "gray40" title "Honest"
set output

filename="BSV_Honest_proportion_earned_add_hash"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Proportion earned' 
set xlabel 'BCH/BSV Honest {/Symbol a} (%)'
set yrange [0:1]
set key top
set key left
plot data using ($1*100):2 with lines lw 4 lc rgb "red" dashtype 2 title "{/Symbol g} = 0", data using ($1*100):4 with lines lw 4 lc rgb "green" dashtype 4 title "{/Symbol g} = 0.5", data using ($1*100):6 with lines lw 4 lc rgb "blue" dashtype 3 title "{/Symbol g} = 1", data using ($1*100):8 with lines lw 4 lc rgb "gray40" title "Honest"
set output

filename="BSV_Selfish_timestep_target_block_time_add_hash"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set yrange [0:*]
set xrange [0:16000]; set xtics 0, 4000, 16000
set key bottom
set key right
set xlabel 'BCH/BSV Timesteps (blocks mined)'
set ylabel 'Minutes' 
plot data using 1:($2 == -1 ? NaN : $2) with line lw 4 lc rgb "red" dashtype 2  title '{/Symbol a} = 10%', data using 1:($2 == -1 ? NaN : $2):($3 == -1 ? NaN : $3) every 2000 with errorbars lw 4 lc rgb "black" notitle, data using 1:($4 == -1 ? NaN : $4) with line lw 4 lc rgb "blue" dashtype 3  title '{/Symbol a} = 33%', data using 1:($4 == -1 ? NaN : $4):($5 == -1 ? NaN : $5) every 2000 with errorbars lw 4 lc rgb "black" notitle, data using 1:($6 == -1 ? NaN : $6) with line lw 4 lc rgb "green" dashtype 4  title '{/Symbol a} = 49%', data using 1:($6 == -1 ? NaN : $6):($7 == -1 ? NaN : $7) every 2000 with errorbars lw 4 lc rgb "black" notitle
set output

filename="BSV_Honest_timestep_target_block_time_add_hash"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Minutes' 
set yrange [0:*]
set xrange [0:8064]; set xtics 0, 2000, 8064
set key bottom
set key right
set xlabel 'BCH/BSV Timesteps (blocks mined)'
plot data using 1:($2 == -1 ? NaN : $2) with line lw 4 lc rgb "red" dashtype 2  title '{/Symbol a} = 10%', data using 1:($2 == -1 ? NaN : $2):($3 == -1 ? NaN : $3) every 2000 with errorbars lw 4 lc rgb "black" notitle, data using 1:($4 == -1 ? NaN : $4) with line lw 4 lc rgb "blue" dashtype 3  title '{/Symbol a} = 33%', data using 1:($4 == -1 ? NaN : $4):($5 == -1 ? NaN : $5) every 2000 with errorbars lw 4 lc rgb "black" notitle, data using 1:($6 == -1 ? NaN : $6) with line lw 4 lc rgb "green" dashtype 4  title '{/Symbol a} = 49%', data using 1:($6 == -1 ? NaN : $6):($7 == -1 ? NaN : $7) every 2000 with errorbars lw 4 lc rgb "black" notitle
set output

filename="BSV_Selfish_timestep_diff_add_hash"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Difficulty (10^{20})'
set yrange [0:70]
set xrange [0:16000]; set xtics 0, 4000, 16000
set key bottom left
set xlabel 'BCH/BSV Timesteps (blocks mined)'
plot data using 1:($2 == -1 ? NaN : ($2/1.0e20)) with line lw 4 lc rgb "red" dashtype 2  title '{/Symbol a} = 10%', data using 1:($4 == -1 ? NaN : ($4/1.0e20)) with line lw 4 lc rgb "blue" dashtype 3  title '{/Symbol a} = 33%', data using 1:($6 == -1 ? NaN : ($6/1.0e20)) with line lw 4 lc rgb "green" dashtype 4  title '{/Symbol a} = 49%'
set output

filename="BSV_Honest_timestep_diff_add_hash"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Difficulty (10^{20})'
set yrange [0:70]
set xrange [0:8064]; set xtics 0, 2000, 8064
set key bottom left
set xlabel 'BCH/BSV Timesteps (blocks mined)'
plot data using 1:($2 == -1 ? NaN : ($2/1.0e20)) with line lw 4 lc rgb "red" dashtype 2  title '{/Symbol a} = 10%', data using 1:($4 == -1 ? NaN : ($4/1.0e20)) with line lw 4 lc rgb "blue" dashtype 3  title '{/Symbol a} = 33%', data using 1:($6 == -1 ? NaN : ($6/1.0e20)) with line lw 4 lc rgb "green" dashtype 4  title '{/Symbol a} = 49%'
set output

filename="BSV_Selfish_timestep_profit_blocks_per_minute_add_hash"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Blocks/Minute' 
set yrange [0:0.15]
set xrange [0:16000]; set xtics 0, 4000, 16000
set key top right
set xlabel 'BCH/BSV Timesteps (blocks mined)'
plot data using 1:($2 == -1 ? NaN : $2) with line lw 4 lc rgb "red" dashtype 2  title '{/Symbol a} = 10%', data using 1:($2 == -1 ? NaN : $2):($3 == -1 ? NaN : $3) every 2000 with errorbars lw 4 lc rgb "black" notitle, data using 1:($4 == -1 ? NaN : $4) with line lw 4 lc rgb "blue" dashtype 3  title '{/Symbol a} = 33%', data using 1:($4 == -1 ? NaN : $4):($5 == -1 ? NaN : $5) every 2000 with errorbars lw 4 lc rgb "black" notitle, data using 1:($6 == -1 ? NaN : $6) with line lw 4 lc rgb "green" dashtype 4  title '{/Symbol a} = 49%', data using 1:($6 == -1 ? NaN : $6):($7 == -1 ? NaN : $7) every 2000 with errorbars lw 4 lc rgb "black" notitle
set output

filename="BSV_Honest_timestep_profit_blocks_per_minute_add_hash"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Blocks/Minute' 
set yrange [0:0.15]
set xrange [0:8064]; set xtics 0, 2000, 8064
set xlabel 'BCH/BSV Timesteps (blocks mined)'
plot data using 1:($2 == -1 ? NaN : $2) with line lw 4 lc rgb "red" dashtype 2  title '{/Symbol a} = 10%', data using 1:($2 == -1 ? NaN : $2):($3 == -1 ? NaN : $3) every 2000 with errorbars lw 4 lc rgb "black" notitle, data using 1:($4 == -1 ? NaN : $4) with line lw 4 lc rgb "blue" dashtype 3  title '{/Symbol a} = 33%', data using 1:($4 == -1 ? NaN : $4):($5 == -1 ? NaN : $5) every 2000 with errorbars lw 4 lc rgb "black" notitle, data using 1:($6 == -1 ? NaN : $6) with line lw 4 lc rgb "green" dashtype 4  title '{/Symbol a} = 49%', data using 1:($6 == -1 ? NaN : $6):($7 == -1 ? NaN : $7) every 2000 with errorbars lw 4 lc rgb "black" notitle
set output

filename="XMR_Selfish_blocks_per_minute_add_hash"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Blocks/Minute' 
set xlabel 'XMR Selfish {/Symbol a} (%)'
set xrange [0:50]; set xtics 0, 10, 50; set xtics 0, 10, 50 
set yrange [0:0.5]
set key top
set key left
plot data using ($1*100):2 with lines lw 4 lc rgb "red" dashtype 2 title "{/Symbol g} = 0", data using ($1*100):4 with lines lw 4 lc rgb "green" dashtype 4 title "{/Symbol g} = 0.5", data using ($1*100):6 with lines lw 4 lc rgb "blue" dashtype 3 title "{/Symbol g} = 1", data using ($1*100):8 with lines lw 4 lc rgb "gray40" title "Honest"
set output

filename="XMR_Honest_blocks_per_minute_add_hash"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Blocks/Minute' 
set xlabel 'XMR Honest {/Symbol a} (%)'
set xrange [0:50]; set xtics 0, 10, 50; set xtics 0, 10, 50 
set yrange [0:0.5]
set key top
set key left
plot data using ($1*100):2 with lines lw 4 lc rgb "red" dashtype 2 title "{/Symbol g} = 0", data using ($1*100):4 with lines lw 4 lc rgb "green" dashtype 4 title "{/Symbol g} = 0.5", data using ($1*100):6 with lines lw 4 lc rgb "blue" dashtype 3 title "{/Symbol g} = 1", data using ($1*100):8 with lines lw 4 lc rgb "gray40" title "Honest"
set output

filename="XMR_Selfish_proportion_earned_add_hash"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Proportion earned' 
set xlabel 'XMR Selfish {/Symbol a} (%)'
set yrange [0:1]
set key top
set key left
plot data using ($1*100):2 with lines lw 4 lc rgb "red" dashtype 2 title "{/Symbol g} = 0", data using ($1*100):4 with lines lw 4 lc rgb "green" dashtype 4 title "{/Symbol g} = 0.5", data using ($1*100):6 with lines lw 4 lc rgb "blue" dashtype 3 title "{/Symbol g} = 1", data using ($1*100):8 with lines lw 4 lc rgb "gray40" title "Honest"
set output

filename="XMR_Honest_proportion_earned_add_hash"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Proportion earned' 
set xlabel 'XMR Honest {/Symbol a} (%)'
set yrange [0:1]
set key top
set key left
plot data using ($1*100):2 with lines lw 4 lc rgb "red" dashtype 2 title "{/Symbol g} = 0", data using ($1*100):4 with lines lw 4 lc rgb "green" dashtype 4 title "{/Symbol g} = 0.5", data using ($1*100):6 with lines lw 4 lc rgb "blue" dashtype 3 title "{/Symbol g} = 1", data using ($1*100):8 with lines lw 4 lc rgb "gray40" title "Honest"
set output

filename="XMR_Selfish_timestep_target_block_time_add_hash"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Minutes' 
set yrange [0:3]
set xrange [0:16000]; set xtics 0, 4000, 16000
set key bottom
set key right
set xlabel 'XMR Timesteps (blocks mined)'
plot data using 1:($2 == -1 ? NaN : $2) with line lw 4 lc rgb "red" dashtype 2  title '{/Symbol a} = 10%', data using 1:($2 == -1 ? NaN : $2):($3 == -1 ? NaN : $3) every 2000 with errorbars lw 4 lc rgb "black" notitle, data using 1:($4 == -1 ? NaN : $4) with line lw 4 lc rgb "blue" dashtype 3  title '{/Symbol a} = 33%', data using 1:($4 == -1 ? NaN : $4):($5 == -1 ? NaN : $5) every 2000 with errorbars lw 4 lc rgb "black" notitle, data using 1:($6 == -1 ? NaN : $6) with line lw 4 lc rgb "green" dashtype 4  title '{/Symbol a} = 49%', data using 1:($6 == -1 ? NaN : $6):($7 == -1 ? NaN : $7) every 2000 with errorbars lw 4 lc rgb "black" notitle
set output

filename="XMR_Honest_timestep_target_block_time_add_hash"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Minutes' 
set yrange [0:3]
set xrange [0:8064]; set xtics 0, 2000, 8064
set xlabel 'XMR Timesteps (blocks mined)'
plot data using 1:($2 == -1 ? NaN : $2) with line lw 4 lc rgb "red" dashtype 2  title '{/Symbol a} = 10%', data using 1:($2 == -1 ? NaN : $2):($3 == -1 ? NaN : $3) every 2000 with errorbars lw 4 lc rgb "black" notitle, data using 1:($4 == -1 ? NaN : $4) with line lw 4 lc rgb "blue" dashtype 3  title '{/Symbol a} = 33%', data using 1:($4 == -1 ? NaN : $4):($5 == -1 ? NaN : $5) every 2000 with errorbars lw 4 lc rgb "black" notitle, data using 1:($6 == -1 ? NaN : $6) with line lw 4 lc rgb "green" dashtype 4  title '{/Symbol a} = 49%', data using 1:($6 == -1 ? NaN : $6):($7 == -1 ? NaN : $7) every 2000 with errorbars lw 4 lc rgb "black" notitle
set output

filename="XMR_Selfish_timestep_diff_add_hash"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Difficulty (10^{20})'
set yrange [0:13]
set xrange [0:16000]; set xtics 0, 4000, 16000
set key bottom left
set xlabel 'XMR Timesteps (blocks mined)'
plot data using 1:($2 == -1 ? NaN : ($2/1.0e20)) with line lw 4 lc rgb "red" dashtype 2  title '{/Symbol a} = 10%', data using 1:($4 == -1 ? NaN : ($4/1.0e20)) with line lw 4 lc rgb "blue" dashtype 3  title '{/Symbol a} = 33%', data using 1:($6 == -1 ? NaN : ($6/1.0e20)) with line lw 4 lc rgb "green" dashtype 4  title '{/Symbol a} = 49%'
set output

filename="XMR_Honest_timestep_diff_add_hash"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Difficulty (10^{20})'
set yrange [0:13]
set xrange [0:8064]; set xtics 0, 2000, 8064
set key bottom left
set xlabel 'XMR Timesteps (blocks mined)'
plot data using 1:($2 == -1 ? NaN : ($2/1.0e20)) with line lw 4 lc rgb "red" dashtype 2  title '{/Symbol a} = 10%', data using 1:($4 == -1 ? NaN : ($4/1.0e20)) with line lw 4 lc rgb "blue" dashtype 3  title '{/Symbol a} = 33%', data using 1:($6 == -1 ? NaN : ($6/1.0e20)) with line lw 4 lc rgb "green" dashtype 4  title '{/Symbol a} = 49%'
set output

filename="XMR_Selfish_timestep_profit_blocks_per_minute_add_hash"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Blocks/Minute' 
set key top right
set yrange [0:0.7]
set xrange [0:16000]; set xtics 0, 4000, 16000
set xlabel 'XMR Timesteps (blocks mined)'
plot data using 1:($2 == -1 ? NaN : $2) with line lw 4 lc rgb "red" dashtype 2  title '{/Symbol a} = 10%', data using 1:($2 == -1 ? NaN : $2):($3 == -1 ? NaN : $3) every 2000 with errorbars lw 4 lc rgb "black" notitle, data using 1:($4 == -1 ? NaN : $4) with line lw 4 lc rgb "blue" dashtype 3  title '{/Symbol a} = 33%', data using 1:($4 == -1 ? NaN : $4):($5 == -1 ? NaN : $5) every 2000 with errorbars lw 4 lc rgb "black" notitle, data using 1:($6 == -1 ? NaN : $6) with line lw 4 lc rgb "green" dashtype 4  title '{/Symbol a} = 49%', data using 1:($6 == -1 ? NaN : $6):($7 == -1 ? NaN : $7) every 2000 with errorbars lw 4 lc rgb "black" notitle
set output

filename="XMR_Honest_timestep_profit_blocks_per_minute_add_hash"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Blocks/Minute' 
set yrange [0:0.7]
set xrange [0:8064]; set xtics 0, 2000, 8064
set key top right
set xlabel 'XMR Timesteps (blocks mined)'
plot data using 1:($2 == -1 ? NaN : $2) with line lw 4 lc rgb "red" dashtype 2  title '{/Symbol a} = 10%', data using 1:($2 == -1 ? NaN : $2):($3 == -1 ? NaN : $3) every 2000 with errorbars lw 4 lc rgb "black" notitle, data using 1:($4 == -1 ? NaN : $4) with line lw 4 lc rgb "blue" dashtype 3  title '{/Symbol a} = 33%', data using 1:($4 == -1 ? NaN : $4):($5 == -1 ? NaN : $5) every 2000 with errorbars lw 4 lc rgb "black" notitle, data using 1:($6 == -1 ? NaN : $6) with line lw 4 lc rgb "green" dashtype 4  title '{/Symbol a} = 49%', data using 1:($6 == -1 ? NaN : $6):($7 == -1 ? NaN : $7) every 2000 with errorbars lw 4 lc rgb "black" notitle
set output

filename="ETH_Honest_blocks_per_minute_add_hash"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Blocks/Minute' 
set xlabel 'ETH Honest {/Symbol a} (%)'
set xrange [0:50]; set xtics 0, 10, 50
set yrange [0:4]
set key top left
plot data using ($1*100):2 with lines lw 4 lc rgb "red" dashtype 2 title "{/Symbol g} = 0", data using ($1*100):4 with lines lw 4 lc rgb "green" dashtype 4 title "{/Symbol g} = 0.5", data using ($1*100):6 with lines lw 4 lc rgb "blue" dashtype 3 title "{/Symbol g} = 1", data using ($1*100):8 with lines lw 4 lc rgb "gray40" notitle, data using ($1*100):9 with lines lw 4 lc rgb "gray40" title "Bounds"
set output

filename="ETH_Selfish_blocks_per_minute_add_hash"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Blocks/Minute' 
set xlabel 'ETH Selfish {/Symbol a} (%)'
set xrange [0:50]; set xtics 0, 10, 50
set yrange [0:4]
set key top
set key left
plot data using ($1*100):2 with lines lw 4 lc rgb "red" dashtype 2 title "{/Symbol g} = 0", data using ($1*100):4 with lines lw 4 lc rgb "green" dashtype 4 title "{/Symbol g} = 0.5", data using ($1*100):6 with lines lw 4 lc rgb "blue" dashtype 3 title "{/Symbol g} = 1", data using ($1*100):10 with lines lw 4 lc rgb "gray40" title "Honest"
set output

filename="ETH_Selfish_proportion_earned_add_hash"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Proportion earned' 
set xlabel 'ETH Selfish {/Symbol a} (%)'
set yrange [0:1]
set key top
set key left
plot data using ($1*100):2 with lines lw 4 lc rgb "red" dashtype 2 title "{/Symbol g} = 0", data using ($1*100):4 with lines lw 4 lc rgb "green" dashtype 4 title "{/Symbol g} = 0.5", data using ($1*100):6 with lines lw 4 lc rgb "blue" dashtype 3 title "{/Symbol g} = 1", data using ($1*100):8 with lines lw 4 lc rgb "gray40" title "Honest"
set output

filename="ETH_Honest_proportion_earned_add_hash"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Proportion earned' 
set xlabel 'ETH Honest {/Symbol a} (%)'
set yrange [0:1]
set key top
set key left
plot data using ($1*100):2 with lines lw 4 lc rgb "red" dashtype 2 title "{/Symbol g} = 0", data using ($1*100):4 with lines lw 4 lc rgb "green" dashtype 4 title "{/Symbol g} = 0.5", data using ($1*100):6 with lines lw 4 lc rgb "blue" dashtype 3 title "{/Symbol g} = 1", data using ($1*100):8 with lines lw 4 lc rgb "gray40" title "Honest"
set output

filename="ETH_Selfish_timestep_target_block_time_add_hash"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Seconds' 
set yrange [0:20]
set xrange [0:16000]; set xtics 0, 4000, 16000
set key bottom
set key right
set xlabel 'ETH Timesteps (blocks mined)'
plot data using 1:(($2 == -1 ? NaN : $2) * 60) with line lw 4 lc rgb "red" dashtype 2  title '{/Symbol a} = 10%', data using 1:(($2 == -1 ? NaN : $2) * 60):(($3 == -1 ? NaN : $3) * 60) every 2000 with errorbars lw 4 lc rgb "black" notitle, data using 1:(($4 == -1 ? NaN : $4) * 60) with line lw 4 lc rgb "blue" dashtype 3  title '{/Symbol a} = 33%', data using 1:(($4 == -1 ? NaN : $4) * 60):(($5 == -1 ? NaN : $5) * 60) every 2000 with errorbars lw 4 lc rgb "black" notitle, data using 1:(($6 == -1 ? NaN : $6) * 60) with line lw 4 lc rgb "green" dashtype 4  title '{/Symbol a} = 49%', data using 1:(($6 == -1 ? NaN : $6)  * 60):(($7 == -1 ? NaN : $7)  * 60) every 2000 with errorbars lw 4 lc rgb "black" notitle, 17 dt '-' lw 4 lc rgb "black" notitle, 9 dt '-' lw 4 lc rgb "black" notitle
set output

filename="ETH_Honest_timestep_target_block_time_add_hash"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Seconds' 
set yrange [0:20]
set xrange [0:8064]; set xtics 0, 2000, 8064
set key bottom
set key right
set xlabel 'ETH Timesteps (blocks mined)'
plot data using 1:(($2 == -1 ? NaN : $2) * 60) with line lw 4 lc rgb "red" dashtype 2  title '{/Symbol a} = 10%', data using 1:(($2 == -1 ? NaN : $2) * 60):(($3 == -1 ? NaN : $3) * 60) every 2000 with errorbars lw 4 lc rgb "black" notitle, data using 1:(($4 == -1 ? NaN : $4) * 60) with line lw 4 lc rgb "blue" dashtype 3  title '{/Symbol a} = 33%', data using 1:(($4 == -1 ? NaN : $4) * 60):(($5 == -1 ? NaN : $5) * 60) every 2000 with errorbars lw 4 lc rgb "black" notitle, data using 1:(($6 == -1 ? NaN : $6) * 60) with line lw 4 lc rgb "green" dashtype 4  title '{/Symbol a} = 49%', data using 1:(($6 == -1 ? NaN : $6)  * 60):(($7 == -1 ? NaN : $7)  * 60) every 2000 with errorbars lw 4 lc rgb "black" notitle, 17 dt '-' lw 4 lc rgb "black" notitle, 9 dt '-' lw 4 lc rgb "black" notitle
set output

filename="ETH_Selfish_timestep_diff_add_hash"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Difficulty (10^{20})'
set key bottom left
set yrange [0 :1.4]
set xrange [0:16000]; set xtics 0, 4000, 16000
set xlabel 'ETH Timesteps (blocks mined)'
plot data using 1:($2 == -1 ? NaN : ($2/1.0e20)) with line lw 4 lc rgb "red" dashtype 2  title '{/Symbol a} = 10%', data using 1:($4 == -1 ? NaN : ($4/1.0e20)) with line lw 4 lc rgb "blue" dashtype 3  title '{/Symbol a} = 33%', data using 1:($6 == -1 ? NaN : ($6/1.0e20)) with line lw 4 lc rgb "green" dashtype 4  title '{/Symbol a} = 49%'
set output

filename="ETH_Honest_timestep_diff_add_hash"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set key bottom left
set ylabel 'Difficulty (10^{20})'
set yrange [0:1.4]
set xrange [0:8064]; set xtics 0, 2000, 8064
set xlabel 'ETH Timesteps (blocks mined)'
plot data using 1:($2 == -1 ? NaN : ($2/1.0e20)) with line lw 4 lc rgb "red" dashtype 2  title '{/Symbol a} = 10%', data using 1:($4 == -1 ? NaN : ($4/1.0e20)) with line lw 4 lc rgb "blue" dashtype 3  title '{/Symbol a} = 33%', data using 1:($6 == -1 ? NaN : ($6/1.0e20)) with line lw 4 lc rgb "green" dashtype 4  title '{/Symbol a} = 49%'
set output

filename="ETH_Selfish_timestep_profit_blocks_per_minute_add_hash"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Blocks/Minute' 
set yrange [0:6]
set xrange [0:16000]; set xtics 0, 4000, 16000
set key top right
set xlabel 'ETH Timesteps (blocks mined)'
plot data using 1:($2 == -1 ? NaN : $2) with line lw 4 lc rgb "red" dashtype 2  title '{/Symbol a} = 10%', data using 1:($2 == -1 ? NaN : $2):($3 == -1 ? NaN : $3) every 2000 with errorbars lw 4 lc rgb "black" notitle, data using 1:($4 == -1 ? NaN : $4) with line lw 4 lc rgb "blue" dashtype 3  title '{/Symbol a} = 33%', data using 1:($4 == -1 ? NaN : $4):($5 == -1 ? NaN : $5) every 2000 with errorbars lw 4 lc rgb "black" notitle, data using 1:($6 == -1 ? NaN : $6) with line lw 4 lc rgb "green" dashtype 4  title '{/Symbol a} = 49%', data using 1:($6 == -1 ? NaN : $6):($7 == -1 ? NaN : $7) every 2000 with errorbars lw 4 lc rgb "black" notitle
set output

filename="ETH_Honest_timestep_profit_blocks_per_minute_add_hash"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Blocks/Minute' 
set yrange [0:6]
set xrange [0:8064]; set xtics 0, 2000, 8064
set xlabel 'ETH Timesteps (blocks mined)'
plot data using 1:($2 == -1 ? NaN : $2) with line lw 4 lc rgb "red" dashtype 2  title '{/Symbol a} = 10%', data using 1:($2 == -1 ? NaN : $2):($3 == -1 ? NaN : $3) every 2000 with errorbars lw 4 lc rgb "black" notitle, data using 1:($4 == -1 ? NaN : $4) with line lw 4 lc rgb "blue" dashtype 3  title '{/Symbol a} = 33%', data using 1:($4 == -1 ? NaN : $4):($5 == -1 ? NaN : $5) every 2000 with errorbars lw 4 lc rgb "black" notitle, data using 1:($6 == -1 ? NaN : $6) with line lw 4 lc rgb "green" dashtype 4  title '{/Symbol a} = 49%', data using 1:($6 == -1 ? NaN : $6):($7 == -1 ? NaN : $7) every 2000 with errorbars lw 4 lc rgb "black" notitle
set output

filename="BTC_Selfish_blocks_per_minute"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Blocks/Minute' 
set xlabel 'BTC Selfish {/Symbol a} (%)'
set xrange [0:50]; set xtics 0, 10, 50
set yrange [0:.1]
set key top
set key left
plot data using ($1*100):2 with lines lw 4 lc rgb "red" dashtype 2 title "{/Symbol g} = 0", data using ($1*100):4 with lines lw 4 lc rgb "green" dashtype 4 title "{/Symbol g} = 0.5", data using ($1*100):6 with lines lw 4 lc rgb "blue" dashtype 3 title "{/Symbol g} = 1", data using ($1*100):8 with lines lw 4 lc rgb "gray40" title "Honest"
set output

filename="BTC_Selfish_proportion_earned"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Proportion earned' 
set xlabel 'BTC Selfish {/Symbol a} (%)'
set yrange [0:1]
set key top
set key left
plot data using ($1*100):2 with lines lw 4 lc rgb "red" dashtype 2 title "{/Symbol g} = 0", data using ($1*100):4 with lines lw 4 lc rgb "green" dashtype 4 title "{/Symbol g} = 0.5", data using ($1*100):6 with lines lw 4 lc rgb "blue" dashtype 3 title "{/Symbol g} = 1", data using ($1*100):8 with lines lw 4 lc rgb "gray40" title "Honest"
set output


filename="BTC_Selfish_timestep_target_block_time"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set yrange [0:*]
set xrange [0:16000]; set xtics 0, 4000, 16000
set key bottom right
set ylabel 'Minutes' 
set xlabel 'BTC Timesteps (blocks mined)'
plot data using 1:($2 == -1 ? NaN : $2) with line lw 4 lc rgb "red" dashtype 2  title '{/Symbol a} = 10%', data using 1:($2 == -1 ? NaN : $2):($3 == -1 ? NaN : $3) every 2016 with errorbars lw 4 lc rgb "black" notitle, data using 1:($4 == -1 ? NaN : $4) with line lw 4 lc rgb "blue" dashtype 3  title '{/Symbol a} = 33%', data using 1:($4 == -1 ? NaN : $4):($5 == -1 ? NaN : $5) every 2016 with errorbars lw 4 lc rgb "black" notitle, data using 1:($6 == -1 ? NaN : $6) with line lw 4 lc rgb "green" dashtype 4  title '{/Symbol a} = 49%', data using 1:($6 == -1 ? NaN : $6):($7 == -1 ? NaN : $7) every 2016 with errorbars lw 4 lc rgb "black" notitle
set output


filename="BTC_Selfish_timestep_diff"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Difficulty (10^{20})'
set yrange [0:70]
set xrange [0:16000]; set xtics 0, 4000, 16000
set key bottom left
set xlabel 'BTC Timesteps (blocks mined)'
plot data using 1:($2 == -1 ? NaN : ($2/1.0e20)) with line lw 4 lc rgb "red" dashtype 2  title '{/Symbol a} = 10%', data using 1:($4 == -1 ? NaN : ($4/1.0e20)) with line lw 4 lc rgb "blue" dashtype 3  title '{/Symbol a} = 33%', data using 1:($6 == -1 ? NaN : ($6/1.0e20)) with line lw 4 lc rgb "green" dashtype 4  title '{/Symbol a} = 49%'
set output


filename="BTC_Selfish_timestep_profit_blocks_per_minute"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Blocks/Minute' 
set yrange [0:0.15]
set xrange [0:16000]; set xtics 0, 4000, 16000
set key top right
set xlabel 'BTC Timesteps (blocks mined)'
plot data using 1:($2 == -1 ? NaN : $2) with line lw 4 lc rgb "red" dashtype 2  title '{/Symbol a} = 10%', data using 1:($2 == -1 ? NaN : $2):($3 == -1 ? NaN : $3) every 2016 with errorbars lw 4 lc rgb "black" notitle, data using 1:($4 == -1 ? NaN : $4) with line lw 4 lc rgb "blue" dashtype 3  title '{/Symbol a} = 33%', data using 1:($4 == -1 ? NaN : $4):($5 == -1 ? NaN : $5) every 2016 with errorbars lw 4 lc rgb "black" notitle, data using 1:($6 == -1 ? NaN : $6) with line lw 4 lc rgb "green" dashtype 4  title '{/Symbol a} = 49%', data using 1:($6 == -1 ? NaN : $6):($7 == -1 ? NaN : $7) every 2016 with errorbars lw 4 lc rgb "black" notitle
set output


filename="BSV_Selfish_blocks_per_minute"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Blocks/Minute' 
set xlabel 'BCH/BSV Selfish {/Symbol a} (%)'
set xrange [0:50]; set xtics 0, 10, 50
set yrange [0:.1]
set key top
set key left
plot data using ($1*100):2 with lines lw 4 lc rgb "red" dashtype 2 title "{/Symbol g} = 0", data using ($1*100):4 with lines lw 4 lc rgb "green" dashtype 4 title "{/Symbol g} = 0.5", data using ($1*100):6 with lines lw 4 lc rgb "blue" dashtype 3 title "{/Symbol g} = 1", data using ($1*100):8 with lines lw 4 lc rgb "gray40" title "Honest"
set output

filename="BSV_Selfish_proportion_earned"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Proportion earned'  
set xlabel 'BCH/BSV Selfish {/Symbol a} (%)'
set yrange [0:1]
set key top
set key left
plot data using ($1*100):2 with lines lw 4 lc rgb "red" dashtype 2 title "{/Symbol g} = 0", data using ($1*100):4 with lines lw 4 lc rgb "green" dashtype 4 title "{/Symbol g} = 0.5", data using ($1*100):6 with lines lw 4 lc rgb "blue" dashtype 3 title "{/Symbol g} = 1", data using ($1*100):8 with lines lw 4 lc rgb "gray40" title "Honest"
set output


filename="BSV_Selfish_timestep_target_block_time"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set yrange [0:*]
set xrange [0:16000]; set xtics 0, 4000, 16000
set key bottom
set key right
set xlabel 'BCH/BSV Timesteps (blocks mined)'
set ylabel 'Minutes' 
plot data using 1:($2 == -1 ? NaN : $2) with line lw 4 lc rgb "red" dashtype 2  title '{/Symbol a} = 10%', data using 1:($2 == -1 ? NaN : $2):($3 == -1 ? NaN : $3) every 2000 with errorbars lw 4 lc rgb "black" notitle, data using 1:($4 == -1 ? NaN : $4) with line lw 4 lc rgb "blue" dashtype 3  title '{/Symbol a} = 33%', data using 1:($4 == -1 ? NaN : $4):($5 == -1 ? NaN : $5) every 2000 with errorbars lw 4 lc rgb "black" notitle, data using 1:($6 == -1 ? NaN : $6) with line lw 4 lc rgb "green" dashtype 4  title '{/Symbol a} = 49%', data using 1:($6 == -1 ? NaN : $6):($7 == -1 ? NaN : $7) every 2000 with errorbars lw 4 lc rgb "black" notitle
set output


filename="BSV_Selfish_timestep_diff"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Difficulty (10^{20})'
set yrange [0:70]
set xrange [0:16000]; set xtics 0, 4000, 16000
set key bottom left
set xlabel 'BCH/BSV Timesteps (blocks mined)'
plot data using 1:($2 == -1 ? NaN : ($2/1.0e20)) with line lw 4 lc rgb "red" dashtype 2  title '{/Symbol a} = 10%', data using 1:($4 == -1 ? NaN : ($4/1.0e20)) with line lw 4 lc rgb "blue" dashtype 3  title '{/Symbol a} = 33%', data using 1:($6 == -1 ? NaN : ($6/1.0e20)) with line lw 4 lc rgb "green" dashtype 4  title '{/Symbol a} = 49%'
set output

filename="BSV_Selfish_timestep_profit_blocks_per_minute"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Blocks/Minute' 
set yrange [0:0.15]
set xrange [0:16000]; set xtics 0, 4000, 16000
set key top right
set xlabel 'BCH/BSV Timesteps (blocks mined)'
plot data using 1:($2 == -1 ? NaN : $2) with line lw 4 lc rgb "red" dashtype 2  title '{/Symbol a} = 10%', data using 1:($2 == -1 ? NaN : $2):($3 == -1 ? NaN : $3) every 2000 with errorbars lw 4 lc rgb "black" notitle, data using 1:($4 == -1 ? NaN : $4) with line lw 4 lc rgb "blue" dashtype 3  title '{/Symbol a} = 33%', data using 1:($4 == -1 ? NaN : $4):($5 == -1 ? NaN : $5) every 2000 with errorbars lw 4 lc rgb "black" notitle, data using 1:($6 == -1 ? NaN : $6) with line lw 4 lc rgb "green" dashtype 4  title '{/Symbol a} = 49%', data using 1:($6 == -1 ? NaN : $6):($7 == -1 ? NaN : $7) every 2000 with errorbars lw 4 lc rgb "black" notitle
set output


filename="XMR_Selfish_blocks_per_minute"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Blocks/Minute' 
set xlabel 'XMR Selfish {/Symbol a} (%)'
set xrange [0:50]; set xtics 0, 10, 50; set xtics 0, 10, 50 
set yrange [0:0.5]
set key top
set key left
plot data using ($1*100):2 with lines lw 4 lc rgb "red" dashtype 2 title "{/Symbol g} = 0", data using ($1*100):4 with lines lw 4 lc rgb "green" dashtype 4 title "{/Symbol g} = 0.5", data using ($1*100):6 with lines lw 4 lc rgb "blue" dashtype 3 title "{/Symbol g} = 1", data using ($1*100):8 with lines lw 4 lc rgb "gray40" title "Honest"
set output

filename="XMR_Selfish_proportion_earned"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Proportion earned' 
set xlabel 'XMR Selfish {/Symbol a} (%)'
set yrange [0:1]
set key top
set key left
plot data using ($1*100):2 with lines lw 4 lc rgb "red" dashtype 2 title "{/Symbol g} = 0", data using ($1*100):4 with lines lw 4 lc rgb "green" dashtype 4 title "{/Symbol g} = 0.5", data using ($1*100):6 with lines lw 4 lc rgb "blue" dashtype 3 title "{/Symbol g} = 1", data using ($1*100):8 with lines lw 4 lc rgb "gray40" title "Honest"
set output


filename="XMR_Selfish_timestep_target_block_time"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Minutes' 
set yrange [0:3]
set xrange [0:16000]; set xtics 0, 4000, 16000
set key bottom
set key right
set xlabel 'XMR Timesteps (blocks mined)'
plot data using 1:($2 == -1 ? NaN : $2) with line lw 4 lc rgb "red" dashtype 2  title '{/Symbol a} = 10%', data using 1:($2 == -1 ? NaN : $2):($3 == -1 ? NaN : $3) every 2000 with errorbars lw 4 lc rgb "black" notitle, data using 1:($4 == -1 ? NaN : $4) with line lw 4 lc rgb "blue" dashtype 3  title '{/Symbol a} = 33%', data using 1:($4 == -1 ? NaN : $4):($5 == -1 ? NaN : $5) every 2000 with errorbars lw 4 lc rgb "black" notitle, data using 1:($6 == -1 ? NaN : $6) with line lw 4 lc rgb "green" dashtype 4  title '{/Symbol a} = 49%', data using 1:($6 == -1 ? NaN : $6):($7 == -1 ? NaN : $7) every 2000 with errorbars lw 4 lc rgb "black" notitle
set output

filename="XMR_Selfish_timestep_diff"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Difficulty (10^{20})'
set yrange [0:13]
set xrange [0:16000]; set xtics 0, 4000, 16000
set key bottom left
set xlabel 'XMR Timesteps (blocks mined)'
plot data using 1:($2 == -1 ? NaN : ($2/1.0e20)) with line lw 4 lc rgb "red" dashtype 2  title '{/Symbol a} = 10%', data using 1:($4 == -1 ? NaN : ($4/1.0e20)) with line lw 4 lc rgb "blue" dashtype 3  title '{/Symbol a} = 33%', data using 1:($6 == -1 ? NaN : ($6/1.0e20)) with line lw 4 lc rgb "green" dashtype 4  title '{/Symbol a} = 49%'
set output


filename="XMR_Selfish_timestep_profit_blocks_per_minute"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Blocks/Minute' 
set key top right
set yrange [0:0.7]
set xrange [0:16000]; set xtics 0, 4000, 16000
set xlabel 'XMR Timesteps (blocks mined)'
plot data using 1:($2 == -1 ? NaN : $2) with line lw 4 lc rgb "red" dashtype 2  title '{/Symbol a} = 10%', data using 1:($2 == -1 ? NaN : $2):($3 == -1 ? NaN : $3) every 2000 with errorbars lw 4 lc rgb "black" notitle, data using 1:($4 == -1 ? NaN : $4) with line lw 4 lc rgb "blue" dashtype 3  title '{/Symbol a} = 33%', data using 1:($4 == -1 ? NaN : $4):($5 == -1 ? NaN : $5) every 2000 with errorbars lw 4 lc rgb "black" notitle, data using 1:($6 == -1 ? NaN : $6) with line lw 4 lc rgb "green" dashtype 4  title '{/Symbol a} = 49%', data using 1:($6 == -1 ? NaN : $6):($7 == -1 ? NaN : $7) every 2000 with errorbars lw 4 lc rgb "black" notitle
set output


filename="ETH_Selfish_blocks_per_minute"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Blocks/Minute' 
set xlabel 'ETH Selfish {/Symbol a} (%)'
set xrange [0:50]; set xtics 0, 10, 50
set yrange [0:4]
set key top
set key left
plot data using ($1*100):2 with lines lw 4 lc rgb "red" dashtype 2 title "{/Symbol g} = 0", data using ($1*100):4 with lines lw 4 lc rgb "green" dashtype 4 title "{/Symbol g} = 0.5", data using ($1*100):6 with lines lw 4 lc rgb "blue" dashtype 3 title "{/Symbol g} = 1", data using ($1*100):10 with lines lw 4 lc rgb "gray40" title "Honest"
set output

filename="ETH_Selfish_proportion_earned"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Proportion earned' 
set xlabel 'ETH Selfish {/Symbol a} (%)'
set yrange [0:1]
set key top
set key left
plot data using ($1*100):2 with lines lw 4 lc rgb "red" dashtype 2 title "{/Symbol g} = 0", data using ($1*100):4 with lines lw 4 lc rgb "green" dashtype 4 title "{/Symbol g} = 0.5", data using ($1*100):6 with lines lw 4 lc rgb "blue" dashtype 3 title "{/Symbol g} = 1", data using ($1*100):8 with lines lw 4 lc rgb "gray40" title "Honest"
set output


filename="ETH_Selfish_timestep_target_block_time"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Seconds' 
set yrange [0:20]
set xrange [0:16000]; set xtics 0, 4000, 16000
set key bottom
set key right
set xlabel 'ETH Timesteps (blocks mined)'
plot data using 1:(($2 == -1 ? NaN : $2) * 60) with line lw 4 lc rgb "red" dashtype 2  title '{/Symbol a} = 10%', data using 1:(($2 == -1 ? NaN : $2) * 60):(($3 == -1 ? NaN : $3) * 60) every 2000 with errorbars lw 4 lc rgb "black" notitle, data using 1:(($4 == -1 ? NaN : $4) * 60) with line lw 4 lc rgb "blue" dashtype 3  title '{/Symbol a} = 33%', data using 1:(($4 == -1 ? NaN : $4) * 60):(($5 == -1 ? NaN : $5) * 60) every 2000 with errorbars lw 4 lc rgb "black" notitle, data using 1:(($6 == -1 ? NaN : $6) * 60) with line lw 4 lc rgb "green" dashtype 4  title '{/Symbol a} = 49%', data using 1:(($6 == -1 ? NaN : $6)  * 60):(($7 == -1 ? NaN : $7)  * 60) every 2000 with errorbars lw 4 lc rgb "black" notitle, 17 dt '-' lw 4 lc rgb "black" notitle, 9 dt '-' lw 4 lc rgb "black" notitle
set output

filename="ETH_Selfish_timestep_diff"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Difficulty (10^{20})'
set key bottom left
set yrange [0 :1.4]
set xrange [0:16000]; set xtics 0, 4000, 16000
set xlabel 'ETH Timesteps (blocks mined)'
plot data using 1:($2 == -1 ? NaN : ($2/1.0e20)) with line lw 4 lc rgb "red" dashtype 2  title '{/Symbol a} = 10%', data using 1:($4 == -1 ? NaN : ($4/1.0e20)) with line lw 4 lc rgb "blue" dashtype 3  title '{/Symbol a} = 33%', data using 1:($6 == -1 ? NaN : ($6/1.0e20)) with line lw 4 lc rgb "green" dashtype 4  title '{/Symbol a} = 49%'
set output

filename="ETH_Selfish_timestep_profit_blocks_per_minute"
data="data/".filename.".data"
out="graphs/".filename.".pdf"
set output out
set ylabel 'Blocks/Minute' 
set yrange [0:6]
set xrange [0:16000]; set xtics 0, 4000, 16000
set key top right
set xlabel 'ETH Timesteps (blocks mined)'
plot data using 1:($2 == -1 ? NaN : $2) with line lw 4 lc rgb "red" dashtype 2  title '{/Symbol a} = 10%', data using 1:($2 == -1 ? NaN : $2):($3 == -1 ? NaN : $3) every 2000 with errorbars lw 4 lc rgb "black" notitle, data using 1:($4 == -1 ? NaN : $4) with line lw 4 lc rgb "blue" dashtype 3  title '{/Symbol a} = 33%', data using 1:($4 == -1 ? NaN : $4):($5 == -1 ? NaN : $5) every 2000 with errorbars lw 4 lc rgb "black" notitle, data using 1:($6 == -1 ? NaN : $6) with line lw 4 lc rgb "green" dashtype 4  title '{/Symbol a} = 49%', data using 1:($6 == -1 ? NaN : $6):($7 == -1 ? NaN : $7) every 2000 with errorbars lw 4 lc rgb "black" notitle
set output


