def clockwiseSpiral(ary):
    n = True
    e = False
    s = False
    w = False
    
    col = len(ary[0])
    # row = len(ary)
    # row_stop = (row/2) + (row%2)
    col_stop = (col/2) + (col%2) - 1

    start = 0
    end = col-1

    while (start < col_stop):

        inner_counter = 0
        while (inner_counter < end):
            print "East:"
            print ary[start][inner_counter]
            inner_counter+=1

        inner_counter = 0
        while (inner_counter < end):
            print 'South:'
            print ary[inner_counter][end]
            inner_counter+=1
        # print end
        
        start+=1



ary = [[1, 2, 3],[4, 5, 6],[7, 8, 9]]

assert(clockwiseSpiral(ary) == "1 2 3 6 9 8 7 4 5")



