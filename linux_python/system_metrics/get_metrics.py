#!/bin/python3
import sys
import psutil

def get_memory():
    mem=psutil.virtual_memory()
    return mem.percent

if __name__ == "__main__":
    result=get_memory()
    print(result)