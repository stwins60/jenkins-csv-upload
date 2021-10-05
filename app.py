import json
import pandas as pd
import argparse, csv



def get_data(data):
    datas = pd.read_csv(data, encoding='utf-8')
    df = pd.DataFrame(datas)
    return df


def get_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('-i', '--input', help='Input file', required=True)
    args = parser.parse_args()
    return args


def main():
    args = get_args()
    data = get_data(args.input)
    print(data)


if __name__ == '__main__':
    main()





