# Kevin Negy

import sys
import random
from sets import Set

BLOCKS = 1000
NEW_SELFISH_MINERS_CPU = [0.1, 0.33, 0.49]
INIT_HASH_POWER = 5e+18   # e+18 is an exahash
RUNS = 100 # Number of tests to run for each hash power

global_hash_power = 0.0    # Global hash power in hashes per second (Calculated)    
global_time = 1.0  # Measured in seconds, starts at 1 and is updated for every second simulated


diff_data = []          # Difficulty (work) log
profit_data = []        # Profit = Total blocks mined by selfish miner
mine_time_data = []     # How long did it take to mine each block
data_index = 0          # Used to access first dimension (hash rate) of logs 
data_run = 0            # Used to access second dimension (run) of logs
timestep_run = False    # Determines if profit data is collected at every timestep or at the end of a run
selfish_ID = 0            # Used for record-keeping
data_path = "data/"
total_blocks = 0

class Block:
    block_ID = 0
    def __init__(self, difficulty, timestamp, height, parent = None, author = None, number = None):
   
        self.difficulty = difficulty     # Expected number of hashes to produce
        self.timestamp = timestamp         # Global time when this block was mined
        self.height = height
        self.parent = parent             # Parent is parent block
        if parent == None:
            self.total_work = 0
        else:
            self.total_work = parent.total_work + difficulty        # Used for honest miners to choose block in a fork
            assert self.total_work > 0 and self.total_work > parent.total_work, "total_work == 0"
        self.author = author             # Which miner produced block
        self.uncles = []                # Only matters in Ethereum
        self.number = number             # Only used for data collection in timestep run
        Block.block_ID += 1

    def __lt__(self, other):
        # Sort a block before another if its height is greater
        if self.height > other.height:
            return True
        elif self.height < other.height:
            return False
        # If height is the same, earlier timestamp goes first
        else:
            return self.timestamp < other.timestamp

    def __str__(self):
        return "[" + "height = " + str(self.height) + ", time = " + str(self.timestamp) + ", " + str(self.difficulty) + ", total_work = "+ str(self.total_work) + ", author = " + str(self.author) + "]" 

# A generic coin protocol and network
class Coin:
    def __init__(self, seconds_between_blocks):
        self.seconds_between_blocks = seconds_between_blocks
        self.miners = []     # Array of miners in network
        self.blocks_produced = 0
        self.broadcast_queue = [] # Array of blocks waiting to be broadcast in network

        # Create a fake history of blocks to allow difficulty to settle down
        assert self.latest_block != None, "Error: self.latest_block not instantiated"
        temp_time = self.latest_block.timestamp

        while self.latest_block.height < 0 :
            temp_time += 1
            # Use Monte Carlo sim to create blocks and then calculate difficulty
            if random.random() <= INIT_HASH_POWER/self.latest_block.difficulty:
                self.latest_block = Block(getattr(self, 'calc_' + self.__class__.__name__ + '_difficulty')(temp_time, self.latest_block),
                                        temp_time,     
                                        self.latest_block.height + 1,
                                        self.latest_block)                # Link parent

        self.start_time = self.latest_block.timestamp                     # Keep track of when selfish miner entered the system
        Block.block_ID = 0

    def create_block(self, time, miner):
        work = getattr(self, 'calc_' + self.__class__.__name__ + '_difficulty')(time, miner.latest_block)
        diff_data[data_index][data_run].append(work)                                            # Log difficulty data
        block = Block(work, time, miner.latest_block.height + 1, miner.latest_block, miner.ID)
        return block

    # Takes block b and prints parent blocks (does not print other forks)
    def print_chain(self, b):
        while b.parent is not None:
            print b
            b = b.parent
        print b         # Reached genesis block

    # Finds longest chain with oldest latest block and calculates how many blocks each miner won
    def calc_winnings(self):
        leaf_set = Set()
        winnings = []

        for miner in self.miners:
            winnings.append(0)
            if miner.latest_block is not None:
                leaf_set.add(miner.latest_block)
        leaf_blocks = []
        for block in leaf_set:
            leaf_blocks.append(block)

        # Sort by height (greatest to least), then by timestamp (oldest first)
        leaf_blocks.sort()

        winning_block = leaf_blocks[0]

        # Traverse block_chain from the leaf array
        b = winning_block
        while b.author is not None:
            winnings[b.author] += 1
            b = b.parent

        return winnings    

    def blocks_won(self):
        return self.calc_winnings()

    # The network is made aware of a new block, notifies all miners
    def queue_block_for_broadcast(self, block):
        # Latest published block has the new public chain height if it's the longest
        if self.latest_block.height < block.height:
            self.latest_block = block

        # Calculate profit of selfish miner at each block published if timestep run
        if timestep_run == True:
            self.blocks_produced += 1             # Block number only needed for data collection in timestep run
            block.number = self.blocks_produced
            winnings = self.calc_winnings()

            if len(profit_data[data_index]) <= block.number:
                profit_data[data_index].append([])

            # global time (seconds), profit (minutes)
            profit_data[data_index][block.number-1].append(winnings[selfish_ID]/((global_time - self.start_time)/60.0))

        self.broadcast_queue.append(block)

    def broadcast_blocks(self):
        for block in self.broadcast_queue:
            # Notify all other miners of new published latest block
            for miner in self.miners:
                if block.author != miner.ID:
                    miner.get_notified(block)
        self.broadcast_queue = []

# Represents the BTC protocol and network
class BTCCoin(Coin):
    def __init__(self):
        self.nPowTargetSpacing = 60 * 10.0                    # target seconds per block 
        self.bnPowLimit = int("00000000ffffffffffffffffffffffffffffffffffffffffffffffffffffffff", 16)
        self.latest_block = None

        # Create a fake history of difficulty period blocks to get started
        for k in range(2017):
            self.latest_block = Block(INIT_HASH_POWER * self.nPowTargetSpacing, 
                                        (2016-k) * -self.nPowTargetSpacing,     # Negative timestamps starts global time at 0
                                        self.latest_block.height + 1 if self.latest_block is not None else -4032, 
                                        self.latest_block)                            # Link parent

        Coin.__init__(self, self.nPowTargetSpacing)
        
    # Return difficulty (expected hashes) required to mine next block
    def calc_BTCCoin_difficulty(self, time, parent):

        DifficultyAdjustmentInterval = 2016
        nPowTargetTimespan = self.nPowTargetSpacing * DifficultyAdjustmentInterval

        if ((parent.height + 1) % DifficultyAdjustmentInterval != 0):
            return parent.difficulty

        # Recalculate difficulty
        first_block = parent
        for i in range(2015):
            first_block = first_block.parent

        assert parent.height - first_block.height + 1 == DifficultyAdjustmentInterval, "Wrong difficulty period length"

        nActualTimespan = parent.timestamp - first_block.timestamp

        # Limit adjustment 
        if (nActualTimespan < nPowTargetTimespan / 4):
            nActualTimespan = nPowTargetTimespan / 4
        elif(nActualTimespan > nPowTargetTimespan * 4):
            nActualTimespan = nPowTargetTimespan * 4

        nbits = self.bnPowLimit / parent.difficulty         # Convert difficulty to target nbits
        bnNew = nbits 
        bnNew *= nActualTimespan
        bnNew /= nPowTargetTimespan 

        if bnNew > self.bnPowLimit:
            bnNew = self.bnPowLimit

        difficulty = self.bnPowLimit / bnNew                 # Convert target back to difficulty

        return difficulty 

# Represents the BCH/BSV protocol and network
class BSVCoin(Coin):
    def __init__(self):
        self.nPowTargetSpacing = 60 * 10.0                    # target seconds per block 
        self.latest_block = None

        # Create a fake history of sliding window blocks to get started
        for k in range(146):
            self.latest_block = Block(INIT_HASH_POWER * self.nPowTargetSpacing, 
                                        (145-k) * -self.nPowTargetSpacing,     # Negative timestamps starts global time at 0
                                        self.latest_block.height + 1 if self.latest_block is not None else -1145, 
                                        self.latest_block)                            # Link parent

        Coin.__init__(self, self.nPowTargetSpacing)
        
    # Return difficulty (expected hashes) required to mine next block
    def calc_BSVCoin_difficulty(self, time, parent):

        # Median of most recent three in our sim is guaranteed to be parent of passed in block
        pindexLast = parent.parent
        pindexFirst = pindexLast
        prev_work = 0

        for i in range(144):
            pindexFirst = pindexFirst.parent

        prev_work = pindexLast.total_work - pindexFirst.total_work

        prev_work *= self.nPowTargetSpacing

        nActualTimespan = pindexLast.timestamp - pindexFirst.timestamp
        assert nActualTimespan > 0, "Error: non-positive time to mine 144 blocks"

        # Bound amplitude of adjustment by x2 or /2
        if (nActualTimespan > 288 * self.nPowTargetSpacing):
            nActualTimespan = 288 * self.nPowTargetSpacing
        elif(nActualTimespan < 72 * self.nPowTargetSpacing):
            nActualTimespan = 72 * self.nPowTargetSpacing

        work = prev_work/ nActualTimespan
        
        # Bitcoin ABC DAA - target isn't needed for simulation
        target = (2**256)/work - 1

        return work

# Represents the ETH protocol and network
class ETHCoin(Coin):
    def __init__(self):
        self.seconds_between_blocks = 15
        self.latest_block = None

        # Create genesis block with expected difficulty
        self.latest_block = Block(INIT_HASH_POWER * self.seconds_between_blocks, 
                                        0,             # Set timestamp to 0
                                        -1000)        # Set block height to -x where x = blocks to simulate with INIT_HASH_POWER

        Coin.__init__(self, self.seconds_between_blocks)

    def create_block(self, time, miner):
        global total_blocks
        total_blocks = total_blocks + 1

        parent = miner.latest_block            # Assume miner latest block is the parent to build on
        assert time > parent.timestamp, "errZeroBlockTime: time less than parent timestep %s %s."%(str(time), str(parent))

        work = getattr(self, 'calc_' + self.__class__.__name__ + '_difficulty')(time, parent)

        diff_data[data_index][data_run].append(work)            # Log difficulty data

        block = Block(work, time, parent.height + 1, parent, miner.ID)

        self.add_uncles(miner, block)

        return block

    # Finds longest chain with oldest latest block and calculates how many blocks each miner won
    def calc_winnings(self):
        leaf_set = Set()
        winnings = []

        for miner in self.miners:
            winnings.append(0)
            if miner.latest_block is not None:
                leaf_set.add(miner.latest_block)
        leaf_blocks = []
        for block in leaf_set:
            leaf_blocks.append(block)

        # Sort by height (greatest to least), then by timestamp (oldest first)
        leaf_blocks.sort()

        winning_block = leaf_blocks[0]

        # Traverse block_chain from the leaf array
        b = winning_block
        block_reward = 1

        while b.author is not None:
            winnings[b.author] += block_reward

            # Calculate reward for uncles 
            for uncle in b.uncles:
                r = (uncle.height + 8 - b.height) * block_reward / 8.0
                winnings[uncle.author] += r

                # For each uncle included, original author of block gets 1/32
                winnings[b.author] += block_reward/32.0
            b = b.parent

        return winnings    

    # Ethereum.calc_winnings includes uncle rewards, Coin.calc_winnings only counts blocks won on main chain
    def blocks_won(self):
        return Coin.calc_winnings(self)

    def add_uncles(self, miner, block):
        # Sort uncles by height
        miner.uncles.sort(key = lambda x: x.height, reverse = True)

        # Get rid of uncles older than 50 blocks - private chain shouldn't be longer than 50
        miner.uncles = miner.uncles[:50]
    
        for uncle in miner.uncles:
            if len(block.uncles) < 2:
                if self.verify_uncle(block, uncle) and uncle not in block.uncles:
                    block.uncles.append(uncle)
                elif block.height - uncle.height > 8:            # Don't waste time searching for uncles farther than certain height
                    break
            elif len(block.uncles) == 2:
                break
            assert len(block.uncles) <= 2, "Error: Too many uncles added to block"
        return 

    # Takes block b and prints last num parent blocks including uncles (does not print other forks)
    def print_chain(self, b, num):
        for i in range(num):
            print("{block} --> ".format(block = b))
            for u in b.uncles:
                print("{unc} --> ".format(unc = u))
            b = b.parent
            print 
        # Reached genesis block
        print b

    # Return difficulty (expected hashes) required to mine next block
    def calc_ETHCoin_difficulty(self, time, parent):
        
        # diff = (parent_diff +
        #         (parent_diff / 2048 * max((2 if len(parent.uncles) else 1) - ((timestamp - parent.timestamp) // 9), -99))
        #         ) + 2^(periodCount - 2)

        bomb_delay = 3000000            # Using bomb delay from Byzantium  (Constantinople uses 5000000)
        difficulty_bound_divisor = 2048
        minimum_difficulty = 131072
        exp_diff_period = 100000
        parent_diff = parent.difficulty

        bomb_delay_from_parents = bomb_delay - 1         # Parent height is one less than current block

        # means > two miners found block at same time. Miner code will choose its own block."
        if time == parent.timestamp:
            parent = parent.parent

        x = int(time - parent.timestamp)

        assert x > 0, "Error: negative time to mine child block, time %r parent %r" % (time, parent.timestamp)

        x = x / 9

        if len(parent.uncles) == 0:
            x = 1 - x
        else:
            x = 2 - x

        if x < -99:            # If true, means more than 100 seconds have passed between parent/child
            x = -99            # Limits how much difficulty can be made easier
        
        y = parent_diff/difficulty_bound_divisor

        x = y * x

        x = parent_diff + x

        # Mininum difficulty check
        if x < minimum_difficulty:
            x = minimum_difficulty

        # Faking block number so that blocks are in Byzantium era
        parent.height += bomb_delay

        # Ice age delay
        fake_block_number = 0
        if parent.height >= bomb_delay_from_parents:
            fake_block_number = parent.height - bomb_delay_from_parents

        # Revert back to actual height
        parent.height -= bomb_delay

        period_count = fake_block_number
        period_count = period_count / exp_diff_period

        # The bomb - diff = diff + 2^(periodCount -2)
        if period_count > 1:
            y = period_count - 2
            y = 2 ** y
            x = x + y

        return x

    def queue_block_for_broadcast(self, block):
        assert self.verify_uncles(block), "Error: uncle blocks were invalid"

        # Latest published block has the new public chain height if it's the longest
        if self.latest_block.height < block.height:
            self.latest_block = block

        # Calculate profit of selfish miner at each block published if timestep run
        if timestep_run == True:
            self.blocks_produced += 1             # Block number only needed for data collection in timestep run
            block.number = self.blocks_produced
            blocks_won = self.blocks_won()              # Ethereum uses blocks won for this stat instead of calc winnings which includes uncles

            if len(profit_data[data_index]) <= block.number:
                profit_data[data_index].append([])

            # global time (seconds), profit (minutes)
            profit_data[data_index][block.number-1].append(blocks_won[selfish_ID]/((global_time - self.start_time)/60.0))
    
        self.broadcast_queue.append(block)

    # Return true if all uncles in block header are valid 
    def verify_uncles(self, block):
        assert len(block.uncles) <= 2, "Error: Too many uncles in block header"
        if len(block.uncles) == 2:
            assert block.uncles[0] != block.uncles[1], "Error: duplicate uncle in same block header"

        for i in block.uncles:
            if self.verify_uncle(block, i) == False:
                return False

        return True

    # Return true if uncle is valid based on main chain block
    def verify_uncle(self, block, uncle):
        ancestors = Set()
        uncles = Set()

        for i in range(7):
            ancestor = block.parent
            
            if ancestor == None:
                break

            for unc in ancestor.uncles:
                uncles.add(unc)

            ancestors.add(ancestor)
            block = ancestor

        ancestors.add(block)
        uncles.add(block)            # Block can't reference itself as uncle

        if uncle in uncles:            # If uncle was already used, false
            return False
        if uncle in ancestors:        # If uncle is on main chain, false
            return False
        if uncle.parent not in ancestors \
                or uncle.parent == block.parent:    # If uncle parent not one of last 7 ancestors or is block sibling, false
                return False

        return True
        
# Represents the XMR protocol and network
class XMRCoin(Coin):
    def __init__(self):

        self.difficulty_target = 60 * 2.0            # target seconds per block 
        self.latest_block = None

        # Create a fake history of sliding window blocks to get started
        for k in range(736):
            self.latest_block = Block(INIT_HASH_POWER * self.difficulty_target, 
                                        (735-k) * -self.difficulty_target,     # Negative timestamps starts global time at 0
                                        self.latest_block.height + 1 if self.latest_block is not None else -1735, 
                                        self.latest_block)                            # Link parent

        Coin.__init__(self, self.difficulty_target)

    def calc_XMRCoin_difficulty(self, time, parent):

        # Defined in seconds
        difficulty_lag = 15
        difficulty_window = 720
        difficulty_cut = 60

        block_window = []
        b = parent
        
        for i in range(difficulty_window + difficulty_lag):
            block_window.append(b)
            b = b.parent

        block_window.reverse()         # Sort from oldest to newest block

        # Resize block_window to fit difficulty_window (ignore latest 15 blocks)
        block_window = block_window[ 0: (len(block_window) - difficulty_lag)]

        # Ignore 60 highest and lowest timestamps
        cut_begin = (len(block_window) - (difficulty_window - 2 * difficulty_cut) + 1 ) / 2
        cut_end = cut_begin + (difficulty_window - 2 * difficulty_cut)
        
        recent_block = block_window[cut_end]
        old_block = block_window[cut_begin]

        target_seconds = self.difficulty_target

        total_work = recent_block.total_work - old_block.total_work
        time_span = recent_block.timestamp - old_block.timestamp
        assert time_span > 0, "Error: non-positive time to mine 600 blocks"

        return ((total_work * target_seconds) + time_span - 1) / time_span

# A generic miner
class Miner:
    miner_ID = 0
    def __init__(self, hash_rate, coin, strategy):
        self.ID = Miner.miner_ID
        Miner.miner_ID += 1
        self.hash_rate = hash_rate
        self.hash_power = global_hash_power * hash_rate
        self.strategy = strategy
        self.difficulty = 0

        # Sign up for cryptocurrency
        self.coin = coin                 
        coin.miners.append(self)
        self.update_latest_block(coin.latest_block)
        self.uncles = []

    def update_latest_block(self, block):
        self.latest_block = block

        # Calculate next block difficulty and cache 
        self.difficulty = getattr(self.coin, 'calc_' + self.coin.__class__.__name__ + '_difficulty')(global_time, block)

    def get_difficulty(self):
        if self.coin.__class__.__name__ == "ETHCoin": #ETH difficulty must always be recalculated with new time
            return getattr(self.coin, 'calc_' + self.coin.__class__.__name__ + '_difficulty')(global_time, self.latest_block)
        return self.difficulty

    def __str__(self):
        return str(self.ID) + " " + str(self.strategy)+ " " + str(self.hash_rate) + " "+ str(self.hash_power)

class HonestMiner(Miner):
    def __init__(self, alpha, coin, gamma = 0):
        Miner.__init__(self, alpha, coin, strategy = "Honest")
        self.in_a_fork = False
        self.fork_choice = []   # [SM block, Honest block]
        self.gamma = gamma

    # Honest miner immediately publishes its found block
    def find_block(self, gamma_won = False):
        if gamma_won == True:
            assert self.in_a_fork == True, "forked"
            assert self.fork_choice[0].author == 0, "gamma won, but block isn't selfish"
            Miner.update_latest_block(self, self.fork_choice[0])

        new_block = self.coin.create_block(global_time, self)
        Miner.update_latest_block(self, new_block)

        if self.in_a_fork == True:
            self.in_a_fork = False

        if self.coin.__class__.__name__ == "ETHCoin":
            self.uncles.append(self.latest_block)

        self.coin.queue_block_for_broadcast(self.latest_block)

    def get_notified(self, block):
        
        # Accept block if it has more total work 
        if block.total_work > self.latest_block.total_work:
            Miner.update_latest_block(self,block)
            
            if self.in_a_fork == True:   # We lost the fork
                self.in_a_fork = False

        elif block != self.latest_block and block.total_work == self.latest_block.total_work:
            self.fork_choice = []
            self.fork_choice.append(block)
            self.fork_choice.append(self.latest_block)
            self.in_a_fork = True

        if self.coin.__class__.__name__ == "ETHCoin":
            self.uncles.append(block)

    def get_gamma_difficulty(self):
            assert self.fork_choice[0].height == self.latest_block.height, "heights are different\n%s\n%s\nlatest sm block %s"%(self.fork_choice[0], self.latest_block, self.coin.miners[0].latest_block)
            assert self.fork_choice[0].total_work == self.latest_block.total_work, "work is different\n%s\n%s"%(self.fork_choice[0], self.latest_block)
            return getattr(self.coin, 'calc_' + self.coin.__class__.__name__ + '_difficulty')(global_time, self.fork_choice[0])

class SelfishMiner(Miner):
    def __init__(self, alpha, coin, strategy = "Selfish"):
        Miner.__init__(self, alpha, coin, strategy)
        self.in_a_fork = False

    def find_block(self):
        new_block = self.coin.create_block(global_time, self)
        Miner.update_latest_block(self,new_block)

        if self.coin.__class__.__name__ == "ETHCoin":
            self.uncles.append(self.latest_block)

        # Publish only if already in a race to win fork
        if self.in_a_fork == True:
            self.coin.queue_block_for_broadcast(self.latest_block)
            self.in_a_fork = False

    def get_notified(self, block):
        difference = self.latest_block.height - block.height

        # Honest wins - adopt latest chain
        if difference <= -1:
            if self.in_a_fork:
                self.in_a_fork = False                        
            Miner.update_latest_block(self,block)

        # Same length - try to win
        elif difference == 0:
            if self.latest_block.author != self.ID:        # Don't care about competing if current block isn't mine
                return

            self.in_a_fork = True
            self.coin.queue_block_for_broadcast(self.latest_block)
            
        # Selfish miner wins with lead of 1
        elif difference == 1:
            self.coin.queue_block_for_broadcast(self.latest_block.parent)
            self.coin.queue_block_for_broadcast(self.latest_block)

        # Selfish miner has greater than 1 lead (guaranteed to win)
        else:
            # Find block that matches height of honest block
            b = self.latest_block
            while b.height != block.height:
                b = b.parent
            self.coin.queue_block_for_broadcast(b)

        if self.coin.__class__.__name__ == "ETHCoin":
            self.uncles.append(block)

class IntermittentSelfishMiner(Miner):
    def __init__(self, alpha, coin):
        Miner.__init__(self, alpha, coin, "Intermittent Selfish Miner")
        self.miners = [SelfishMiner(alpha, coin, "ISM"), HonestMiner(alpha, coin, "ISM")]
        coin.miners.remove(self.miners[0])
        coin.miners.remove(self.miners[1])                            # Only include ISM miner in coin, not self.miners[selfish, honest]
        Miner.miner_ID = len(coin.miners)                            # Reset Miner.miner_ID to account for removed miners
        self.miners[0].ID = self.miners[1].ID = self.ID             # ISM_Selfish and ISM_Honest need to share same ID as ISM
        self.phase = 1        # Initialize with phase one: selfish mining

    def find_block(self):
        self.miners[self.phase - 1].find_block()
        Miner.update_latest_block(self,self.miners[self.phase - 1].latest_block)

        if self.miners[self.phase - 1].latest_block.height % 2016 == 0:
            self.change_phase()

    def get_notified(self, block):
        current_strategy = self.miners[self.phase - 1]
        latest_block = current_strategy.latest_block

        current_strategy.get_notified(block)
        Miner.update_latest_block(self,self.miners[self.phase - 1].latest_block)

        # Only alternate phases if latest block was updated, has new height, and every 2016 blocks
        if latest_block.height != current_strategy.latest_block.height and current_strategy.latest_block.height % 2016 == 0:
            self.change_phase()

    def change_phase(self ):        
            self.miners[self.phase % 2].latest_block = self.latest_block
            self.phase = self.phase % 2 + 1            # Alternates between phase 1 and 2

        
# Monte Carlo simulator (only tested for a two-miner system)
def mining_sim(coin):
    global global_time

    ticker = 0
    while coin.latest_block.height < BLOCKS:
        global_time += 1
        ticker += 1
        block_found = False
        
        for miner in coin.miners:
            # Handle fork
            if coin.miners[1].in_a_fork == True and miner.ID == 1: 
                if random.random() <= (miner.hash_power * (1- miner.gamma)) / miner.get_difficulty():
                    miner.find_block()
                    mine_time_data[data_index][data_run].append(ticker)     # Log block mine_time
                    block_found = True
                elif random.random() <= (miner.hash_power * (miner.gamma)) / miner.get_gamma_difficulty():
                    miner.find_block(True)
                    mine_time_data[data_index][data_run].append(ticker)     # Log block mine_time
                    block_found = True
                continue
                    
            if random.random() <= miner.hash_power/miner.get_difficulty():
                miner.find_block()
                mine_time_data[data_index][data_run].append(ticker)     # Log block mine_time
                block_found = True
        
        # Only notify network about new blocks after every miner has had a fair chance to win a block
        if len(coin.broadcast_queue) > 0:
            coin.broadcast_blocks()       

        if block_found:         # for logging 
            block_found = False
            ticker = 0    
    

def run_test(coin_type, miner_type, test_type, add_hash_power, alpha, gamma):
    global global_time, global_hash_power
    global data_run, data_index, timestep_run
    
    # Data variables
    selfish_blocks_per_min = []
    system_blocks_per_min = []
    proportion_earned = []
    global_hash_power= INIT_HASH_POWER
    selfish_hash_rate = 0.0
    blocks_produced = 0

    if test_type == "timestep":
        timestep_run = True         # To see profits from select hash_rates across each timestep (block)
        new_hash_rate = NEW_SELFISH_MINERS_CPU
    else:
        timestep_run = False             # To see profits at the end of simulations for hash_rates [0:0.5]
        new_hash_rate = [ x * 0.01 for x in range(51) ]    

    if alpha != None:
        new_hash_rate = [float(alpha)]

    # Test for new selfish miner hash_rates
    for i in range(len(new_hash_rate)):
        data_index = i

        # Timestep data
        profit_data.append([])
        diff_data.append([])
        mine_time_data.append([])

        # Whole data
        selfish_blocks_per_min.append([])
        proportion_earned.append([])
        system_blocks_per_min.append([])

        selfish_hash_rate = new_hash_rate[i]

        # Update global hash_rate
        if add_hash_power == "true":
            global_hash_power = (INIT_HASH_POWER/(1-selfish_hash_rate))
    
        # Test with j runs
        for j in range(RUNS):
            data_run = j
            global_time = 1
            total_blocks = 0

            # Reset miner ID numbers
            Miner.miner_ID = 0
            profit_data[data_index].append([])
            diff_data[data_index].append([])
            mine_time_data[data_index].append([])

            # Init coin
            try:
                coin = globals()[coin_type.upper() + "Coin"]()
                global_time = coin.start_time
            except Exception as err:
                print err 
                exception_usage("-coin incorrect option")

            # Create two miners/mining pools using the chosen cryptocurrency
            SM = globals()[miner_type + "Miner"](selfish_hash_rate, coin)
            HM = HonestMiner((1 - selfish_hash_rate), coin, gamma)

            selfish_ID = SM.ID
            
            mining_sim(coin)

            winnings = coin.calc_winnings()    
            blocks_won = coin.blocks_won()
            
            total_blocks_on_main_chain = total_winnings = 0.0
            for m in range(len(winnings)):
                total_winnings += winnings[m]
                total_blocks_on_main_chain += blocks_won[m]

            # Calculate mining data points
            global_minutes = (global_time - coin.start_time) / 60.0
            system_blocks_per_min[i].append(total_blocks_on_main_chain/global_minutes)
            selfish_blocks_per_min[i].append(blocks_won[selfish_ID]/global_minutes)
            proportion_earned[i].append(winnings[selfish_ID]/total_winnings)
            print "         run = " + str(j)    

            if Block.block_ID > blocks_produced:
                blocks_produced = Block.block_ID
        
        print "hash_rate = "+str(selfish_hash_rate)

    add = ""
    if add_hash_power == "true":
        add = "_add_hash"
    
    if timestep_run == True:
        with open(data_path + coin_type + "_" + miner_type +"_timestep_target_block_time" + add +".data", "w") as k:
            k.write("block_number 0.1_avg 0.1_stddev 0.33_avg 0.33_stddev 0.49_avg 0.49_stddev expected\n")
            for i in range(blocks_produced):
                k.write(str(i) + " ")
                for j in range(len(new_hash_rate)):
                    # Pull out block from each run
                    try:
                        block_data = [run[i] for run in mine_time_data[j]]
                        avg = average(block_data)
                        std_dev = stddev(block_data, avg)
                    except:
                        avg = -60
                        std_dev = -60
                    k.write(str(avg/60.0) + " " + str(std_dev/60.0) + " ")
                k.write(str(coin.seconds_between_blocks/60.0) + "\n")

        with open(data_path + coin_type + "_" + miner_type +"_timestep_diff" + add +".data", "w") as k:
            k.write("block_number 0.1_avg 0.1_stddev 0.33_avg 0.33_stddev 0.49_avg 0.49_stddev\n")
            for i in range(blocks_produced):
                k.write(str(i) + " ")
                for j in range(len(new_hash_rate)):
                    # Pull out block from each run
                    try:
                        block_data = [run[i] for run in diff_data[j]]
                        avg = average(block_data)
                        std_dev = stddev(block_data, avg)
                    except:
                        avg = -1 
                        std_dev = -1
                    k.write(str(avg) + " " + str(std_dev) + " ")
                k.write("\n")

        with open(data_path + coin_type + "_" + miner_type +"_timestep_profit_blocks_per_minute" + add +".data", "w") as k:
            k.write("block_number 0.1_avg 0.1_stddev 0.33_avg 0.33_stddev 0.49_avg 0.49_stddev 0.1_expected 0.33_expected 0.49_expected\n")
            for i in range(blocks_produced):
                k.write(str(i) + " ")
                for j in range(len(new_hash_rate)):
                    try:
                        if len(profit_data[j][i]) == RUNS:
                            avg = average(profit_data[j][i])
                            std_dev = stddev(profit_data[j][i], avg)
                        else:
                            avg = -1
                            std_dev = -1
                    except:
                            avg = -1
                            std_dev = -1
                    k.write(str(avg)+ " " + str(std_dev) + " ")
                expected = coin.seconds_between_blocks/60.0
                k.write("{a} {b} {c}\n".format(a = str(0.1 / expected), b = str(0.33/expected), c = str(0.49/expected)))
    else:
        with open(data_path + coin_type + "_" + miner_type + "_blocks_per_minute_" + str(gamma) + add + ".data", "w") as file:
            file.write("hash_rate "+str(gamma)+"_avg " +str(gamma)+"_stddev expected_honest\n")
            for i in range(len(selfish_blocks_per_min)):
                file.write(str(i * 0.01) + " ")
                avg = average(selfish_blocks_per_min[i])
                std_dev = stddev(selfish_blocks_per_min[i], avg)
                file.write(str(avg)+ " " + str(std_dev) + " ")
                file.write(str(i * 0.01 / (coin.seconds_between_blocks/60.0) )+ "\n")

        with open(data_path + coin_type + "_" + miner_type +"_proportion_earned_" + str(gamma) + add + ".data", "w") as file:
            file.write("hash_rate "+str(gamma)+"_avg " +str(gamma)+"_stddev expected_honest\n")
            for i in range(len(proportion_earned)):
                file.write(str(i * 0.01) + " ")
                avg = average(proportion_earned[i])
                std_dev = stddev(proportion_earned[i], avg)
                file.write(str(avg)+ " " + str(std_dev) + " ")
                file.write (str(i * 0.01) + "\n")

        with open(data_path + coin_type + "_" + miner_type + "_system_blocks_per_minute_" + str(gamma) + add + ".data", "w") as file:
            file.write("hash_rate "+str(gamma)+"_avg " +str(gamma)+"_stddev expected_honest\n")
            for i in range(len(system_blocks_per_min)):
                file.write(str(i * 0.01) + " ")
                avg = average(system_blocks_per_min[i])
                std_dev = stddev(system_blocks_per_min[i], avg)
                file.write(str(avg)+ " " + str(std_dev) + " ")
                file.write (str(60.0/coin.seconds_between_blocks) + "\n")            
            
def main():
    global BLOCKS, RUNS
    args = sys.argv
    coin_type = None
    miner_type = None
    test = None
    hash_power = None
    add_hash_power = True
    alpha = None    # Alpha is proportion of SM hash rate
    gamma = 0.0     # Gamma is proportion of honest miners who choose to mine on selfish fork

    for i in range(len(args)):
        if args[i] == "-coin":
                coin_type = args[i+1] 
        elif args[i] == "-test":
            test = args[i+1]
        elif args[i] == "-add_hash_power":
            add_hash_power = args[i+1]
        elif args[i] == "-miner_type":
            miner_type = args[i+1]
        elif args[i] == "-num_blocks":
            try:
                BLOCKS = int(args[i+1])
            except: 
                exception_usage("-num_blocks must be an integer.")
        elif args[i] == "-num_runs":
            try:
                RUNS = int(args[i+1])
            except:
                exception_usage("-num_runs must be an integer.")
        elif args[i] == "-alpha":
            try:
                alpha = float(args[i+1])
            except:
                exception_usage("-alpha must be a float.")
        elif args[i] == "-gamma":
            try:
                gamma = float(args[i+1])
            except:
                exception_usage("-gamma must be float between 0 and 1.")


    if test == "whole" or test == "timestep":
        run_test(coin_type, miner_type, test, add_hash_power, alpha, gamma)
    else:
        exception_usage("-test incorrect option")

def exception_usage(message):
    print "Error:" + message
    print "usage: python selfishminesim.py -coin <coin name> -test <test name> -miner_type <mine type> -num_blocks <integer> -num_runs <integer>" 
    print "-coin: BTC, BSV, XMR, or ETH"
    print "-test: timestep or whole"
    print "-add_hash_power: true or false"
    print "-miner_type: honest or selfish"
    print "-num_blocks: default is 1000"
    print "-num_runs: default is 100"
    print "-alpha: one float between 0 and 0.5 to simulate. (optional)"
    print "-gamma: 0, 0.5, or 1. Default is 0"
    exit()
        
def average(array):
    average = 0.0
    for z in range(len(array)): 
        average += array[z]
    return average/len(array)

def stddev(array, avg):
    squares = 0.0
    N = len(array)
    for z in range(N):
        squares += (array[z]-avg)**2
    squares = squares/N
    return squares ** 0.5

main()
