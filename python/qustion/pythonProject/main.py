# -*- coding: utf-8 -*-
"""
这是一个关于，如何实现获取大数组集去掉多个小数集后的元素个数
    ①小数集之间有重合
    ②大数集：1~10^4,小数集的个数：1~100,小数集存在且是大数集的子集
问题：
    数据的生成？如何相减？
"""
# 输入：大数集，小数集个数，各个小数集
# 输出：大数集去掉小数集后剩余个数

# 导入需要的库（需要用什么就导入什么）
# import os


#数据生成函数
def numcrate(min,max):
    """数组的生成"""
    arr=list(range(min,max))
    return arr
#大数组输入条件判断函数
def flag1(num1,num2):
    if (1<=num1<=10**4)and(1<=num2<=100):
        return 1
    else:
        return 0

#小数组输入条件判断函数
def flag2(num1,num2,num3):
    if (num1<num2<num3):
        return 1
    return 0

#大数组的处理函数
def numHandle(num1,num2):
    # 大数组的生成
    arr_big = numcrate(1,num1 + 1)
    union=small_numHandle(num2,num1)
    # 大减小
    result = list(set(arr_big) - set(union))
    # result=[x for x in arr_big if x not in union]
    # 输出
    print(f"剩余：{len(result)}")
    return

#小数组处理函数
def small_numHandle(quantity,limit):
    union = []  # 初始化union
    # 小数组的生成|合并
    print("输入各区域大小\n")
    for numr in range(quantity):
        inputNum1 = input().split()
        arr_numr = list(map(int, inputNum1))
        if flag2(arr_numr[0],arr_numr[1],limit):
            small_list = numcrate(arr_numr[0], arr_numr[1] + 1)
            union = list(set(union) | set(small_list))
        else :
            print ("数据不匹配！重新输入")
            main()
    return union


#主函数调用
def main():
    """
    主函数：程序从这里开始执行
    所有业务逻辑都写在这个函数里
    """
    while 1:
        #数据的输入|条件判断
        inputNum = input("请输入马路长度和区域数(输入-1退出程序):\n").split()
        arr1 = list(map(int, inputNum))  # 暂存数据
        if arr1[0]==-1:
            break
        if flag1(arr1[0],arr1[1]):
            numHandle(arr1[0],arr1[1])
        else:
            print("输入数据有误！！！重新输入！")
            main()

# 程序入口固定写法
# 只有直接运行这个文件时，才会执行下面代码
if __name__ == '__main__':
    # 调用主函数
    main()

