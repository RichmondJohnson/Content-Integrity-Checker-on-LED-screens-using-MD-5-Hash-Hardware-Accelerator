import datetime
import random
import time
import os
import string
from block import Block

#This code is heavily inspired by:
#https://medium.com/crypto-currently/lets-build-the-tiniest-blockchain-e70965a248b

def main():
    if os.path.exists("blockchain_log.txt"):
        os.remove("blockchain_log.txt")
    start = time.time()
    run("blockchain_log.txt")
    end = time.time()
    elapsed = end - start
    print(elapsed)

def run(filename):
    blockchain = []
    previous = None
    f = open(filename, 'a+')
    #t = 0
    #for j in range(100):
    #    t1 = time.time()
    for i in range(100000):
        new_block = create_block(previous, f)
        blockchain.append(new_block)
        previous = new_block
    #    t2 = time.time()
    #    t += t2-t1
    #print("average time " + str(t/100))
    f.close()

def generate_random_data():
    N = random.randint(1, 101)
    data = ''.join(random.choices(string.ascii_lowercase + string.ascii_uppercase + string.digits, k=N))
    return data

def create_first_block():
    return Block(datetime.datetime.now(), "Init", "0")

def create_block(block, file):
    if block == None:
        block = create_first_block()
    data = generate_random_data()
    new_block = Block(datetime.datetime.now(), data, block.hash)
    file.write("Data: " + data + "\n")
    file.write("Hash: " + new_block.hash + "\n")
    return new_block

if (__name__ == '__main__'):
    main()