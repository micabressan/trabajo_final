import sys
from pycsp.parallel import *
import time

class P:
    def __init__(self, name, keys, weight):
        self.name = name
        self.keys = keys
        self.weight = weight


class V:
    def __init__(self, name, count):
        self.name = name
        self.count = count


class B:
    def __init__(self, name, count):
        self.name = name
        self.count = count


@choice
def callback(type, channel_input = None):
    print(type, channel_input)


def B_lenn(B_arr):
    BLen = 0
    for Bb in B_arr:
        BLen += Bb.count
    return BLen

def add_to_B(B_arr, B_elem):
    found = False
    B_new = B(B_elem.name, 1)
    if len(B_arr) == 0:
        B_arr.append(B_new)
    for i in range(len(B_arr)):
        if B_arr[i].name == B_new.name:
            B_arr[i].count += 1
            return B_arr
        elif B_arr[i].name > B_new.name:
            B_arr = B_arr[:i] + [B_new] + B_arr[i:]
            return B_arr
    B_arr.append(B_new)
    return B_arr


def remove_from_B(B_arr, v1):
    for i in range(len(B_arr)):
        if B_arr[i].name == v1.name and B_arr[i].count >= v1.count:
            B_arr[i].count = B_arr[i].count - v1.count
            if B_arr[i].count == 0:
                del B_arr[i]
            return B_arr
    return B_arr

@process
def consumer(files_msg, IO_V, V_B, controller_msg):
    V_N = int(files_msg.reader()())
    print(V_N)
    V_arr = []
    for i in range(0, V_N):
        V_arr.append(IO_V.reader()())

    controller_msg.writer()(V_N)
    consumer_finished = False
    time.sleep(0.1)
    while consumer_finished is not True:
        messie_t = controller_msg.reader()
        IG = InputGuard(messie_t, action=callback('input'))
        TG = TimeoutGuard(seconds=0.01, action=callback('timeout'))
        stuffs = AltSelect(IG, TG)
        messie = stuffs[1]
        if messie is not None:
            if messie != -1:
                print("Cosnumer needed", V_N)
                for Vv in V_arr:
                    V_B.writer()(Vv)
            else:
                consumer_finished = True
                print("Consumer finished")

    # files_N_i.writer()(V_N)
    # for Vv in V_arr:
    #     print(Vv)


@process
def producer(files_msg, IO_P, P_B, controller_msg):
    P_N = int(files_msg.reader()())
    print(P_N)
    P_arr = []
    for i in range(0, P_N):
        P_arr.append(IO_P.reader()())

    for Pp in P_arr:
        P_B.writer()(Pp)

    controller_msg.writer()(0)
    # files_N_i.writer()(P_N)
    # for Pp in P_arr:
    #     print(Pp)


@process
def files_R(filename_dat, filename_res, P_IO_m_arr, V_IO_m_arr,
            IO_P, IO_V, B_IO, B_IO_m):

    data_file = open(filename_dat,"r")
    P_Count = int(data_file.readline())
    # print(P_Count)
    V_Count = int(data_file.readline())
    #V_Count = int(file.readline())
    # print(V_Count)
    P_all = []
    for i in range(0, P_Count):
        n = int(data_file.readline())
        temp_arr = []
        for j in range(0,n):
            line = data_file.readline()
            values = line.split(" ")
            name = values[0]
            keys = int(values[1])
            weight = float(values[2])
            temp_arr.append(P(name, keys, weight))
        P_all.append(temp_arr)

    V_all = []
    for i in range(0, V_Count):
        n = int(data_file.readline())
        temp_arr = []
        for j in range(0, n):
            line = data_file.readline()
            values = line.split(" ")
            name = values[0]
            count = int(values[1])
            temp_arr.append(V(name, count))
        V_all.append(temp_arr)
    #print(V_all, P_all)

    result_file = open(filename_res,"w")
    dashes = "-------------------------------------"
    for i in range(len(P_all)):
        result_file.write("P nr:" + str(i) + "\n")
        result_file.write(dashes + '\n')
        for j in range(len(P_all[i])):
            s = P_all[i][j].name
            k = P_all[i][j].keys
            d = P_all[i][j].weight
            fullstr = "|" + s + "| " + str(k) + " | " + str(d) + " |\n"
            result_file.write(fullstr)
        result_file.write(dashes + '\n')

    for i in range(len(V_all)):
        result_file.write("V nr:" + str(i) + "\n")
        result_file.write(dashes + '\n')
        for j in range(len(V_all[i])):
            s = V_all[i][j].name
            k = V_all[i][j].count
            fullstr = "|" + s + "| " + str(k) + " |\n"
            result_file.write(fullstr)
        result_file.write(dashes + '\n')

    for i in range(0, P_Count):
        P_IO_m_arr[i].writer()(len(P_all[i]))
        for j in range(0, len(P_all[i])):
            IO_P.writer()(P_all[i][j])

    for i in range(0, V_Count):
        V_IO_m_arr[i].writer()(len(V_all[i]))
        for j in range(0, len(V_all[i])):
            IO_V.writer()(V_all[i][j])
    print("IO will now start controller")
    B_IO_m.writer()("We can starts duh cntroller")

    result_file.close()


@process
def controller(P_C_m_arr, V_C_m_arr, P_B, V_B, B_IO, B_IO_m):
    print("Controller initialised")
    B_IO_m.reader()() #Starts after IO finishes
    print("Controller started")
    B_all = []
    V_Count = len(V_C_m_arr)
    P_Count = len(P_C_m_arr)
    P_to_done = P_Count
    V_total = 0
    for Vv in V_C_m_arr:
        V_total += Vv.reader()()

    print(V_total)
    for Vv in V_C_m_arr:
        Vv.writer()(11)
    V_to_done = V_total
    removed_cycle = False
    added_B = False
    end_loop = False
    cycles_removed = False
    while ((P_to_done > 0 or removed_cycle == True) or (len(B_all) > 0) or added_B == True) and (end_loop == False):
        print("Loopin. B size: " + str(len(B_all)))
        removed_cycle = False
        added_B = False
        p_temp = P_B.reader()
        IG = InputGuard(p_temp, action=callback('input'))
        TG = TimeoutGuard(seconds=0.1, action=callback('timeout'))
        stuffs = AltSelect(IG, TG)
        good_p_temp = stuffs[1]

        if good_p_temp is not None:
            added_B = True
            add_to_B(B_all, good_p_temp)

        if (P_to_done > 0):
            for P_msg in P_C_m_arr:
                tempp = P_msg.reader()
                IGg = InputGuard(tempp, action=callback('input'))
                TGg = TimeoutGuard(seconds=0.01, action=callback('timeout'))
                temp_alt_sel = AltSelect(IGg, TGg)
                if temp_alt_sel[1] is not None:
                    P_to_done -= 1
                else:
                    print('P still active')
                    print('P to done (%d)' % (P_to_done))
        tempp = V_B.reader()
        IGv = InputGuard(tempp, action=callback('input'))
        TGv = TimeoutGuard(seconds=0.1, action=callback('timeout'))
        temp_alt_sel = AltSelect(IGv, TGv)
        V_temp = temp_alt_sel[1]
        if V_temp is not None:
            V_to_done -= 1
            b_temp_cnt = B_lenn(B_all)
            B_all = remove_from_B(B_all, V_temp)
            removed = False
            if (B_lenn(B_all) < b_temp_cnt):
                removed = True
            if removed is True:
                removed_cycle = True
                cycles_removed = True
                print("Removed: ", V_temp.name, V_temp.count)
            else:
                print("Wasn't removed: ", V_temp.name, V_temp.count)
                for Bb in B_all:
                    print(Bb.name, Bb.count)
        else:
            print("Consumer didn't consume")

        if (((cycles_removed is False and V_to_done == 0) or (cycles_removed == True and len(B_all) == 0)) and P_to_done == 0):
            print("End stuff?")
            for V_msg in V_C_m_arr:
                V_msg.writer()(-1)
            end_loop = True
        if ((V_to_done == 0 and cycles_removed is True) and end_loop is False):
            for V_msg in V_C_m_arr:
                V_msg.writer()(1)
            V_to_done = V_total
            cycles_removed = False
    print("Controller ended while loop")
    for B_temp in B_all:
        print("ENDED", B_temp.name, B_temp.count)
        B_IO.writer()(B_temp)

    print("Controller finally ended")
    B_IO_m.writer()(len(B_all))
    B_IO_m.writer()(-1)

@process
def testPrint(printstuffchan):
    while True:
        sys.stdout.write(str(printstuffchan())+str(id)+"\n")


if __name__ == "__main__":
    filename_dat = "IFF59_MinelgaM_L2_dat_1.txt"
    file = open(filename_dat, "r")
    P_Count = int(file.readline())
    V_Count = int(file.readline())
    filename_res = "IFF59_MinelgaM_L3a_rez.txt"
    file.close()

    P_IO_m_arr = []
    P_C_m_arr = []

    V_IO_m_arr = []
    V_C_m_arr = []

    P_B = Channel("P_B", 100)
    IO_P = Channel("IO_P", 100)

    V_B = Channel("V_B", 100)
    IO_V = Channel("IO_V", 100)

    B_IO = Channel()
    B_IO_m = Channel()

    for i in range(0, P_Count):
        P_ch_m_i = Channel()
        P_ch_m_o = Channel()
        P_IO_m_arr.append(P_ch_m_i)
        P_C_m_arr.append(P_ch_m_o)

    for i in range(0, V_Count):
        V_ch_m_i = Channel()
        V_ch_m_o = Channel()
        V_IO_m_arr.append(V_ch_m_i)
        V_C_m_arr.append(V_ch_m_o)


    Spawn(
        1 * files_R(filename_dat, filename_res, P_IO_m_arr, V_IO_m_arr, IO_P, IO_V, B_IO, B_IO_m),
        [producer(P_IO_m_arr[i], IO_P, P_B, P_C_m_arr[i]) for i in range(0, P_Count)],
        [consumer(V_IO_m_arr[i], IO_V, V_B, V_C_m_arr[i]) for i in range(0, V_Count)],
        1 * controller(P_C_m_arr, V_C_m_arr, P_B, V_B, B_IO, B_IO_m)
    )