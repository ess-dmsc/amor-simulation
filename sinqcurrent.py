from random import randint


class SINQProtonCurrentSupport:
    def __init__(self, rec, link):
        pass

    def detach(self, rec):
        pass

    def process(self, rec, reason):
        rec.VAL = randint(10, 1000)


build = SINQProtonCurrentSupport
