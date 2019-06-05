import hashlib

class Block:
    def __init__(self, timestamp, data, prev_hash):
        self.timestamp = timestamp
        self.data = data
        self.prev_hash = prev_hash
        self.hash = self.generate_hash(timestamp, data, prev_hash)

    def generate_hash(self, timestamp, data, hash_prev):
        md5 = hashlib.md5()
        hash_str = str(timestamp)+str(data)+str(hash_prev)
        md5.update(hash_str.encode('utf8'))
        return md5.hexdigest()