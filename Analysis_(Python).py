# PLOTING READS OF PATH_1 VS READS OF PATH_2 of Phage35, COMPARING READS WITH SPECIFIED POSITIONS:
Phage_name = "Phage 35"
import pysam
import matplotlib.pyplot as plt

samfile1 = pysam.AlignmentFile("PHAGE_BUBBLE/Bam_sorted/M524_I6790_27765_Parkes_IBD_292_V4_2_11_16_NEBNextIndex35_CATTTT_S10_L001_path_1_sorted.bam", "rb")
samfile2 = pysam.AlignmentFile("PHAGE_BUBBLE/Bam_sorted/M524_I6790_27765_Parkes_IBD_292_V4_2_11_16_NEBNextIndex35_CATTTT_S10_L001_path_2_sorted.bam", "rb")

x = []
y = []

# Samfile.pileup will isolate the number of reads for every base, "pileipcolumn.n" indicate the value of the read
#The limit is unknown, therefore 0-60000 is a large enough margin.
for pileupcolumn in samfile1.pileup("path_1_edge_91047_edge_5628", 0, 60000): 
    x.append(pileupcolumn.n)
    
samfile1.close()

for pileupcolumn in samfile2.pileup("path_2_edge_91047_edge_91048", 0, 60000):
    y.append(pileupcolumn.n)
    
samfile2.close()

y = y[0:len(x)] # In case that x and y do not have the same size, this ensure that they do.

if None in x:
    print("List contains 0.")
else:
    print("List does not contain 0.")
    
    
fig, ax = plt.subplots()
s = 0.5
ax.scatter(x, y, s)

ax.set_xlabel("Path_1")
ax.set_ylabel("Path_2")
ax.set_yscale('log')
ax.set_xscale('log')
plt.show()

# Finding the location of Varying:
p_dif = [] # P is the set of position where path 1 and path 2 differs
for position in range(len(y)):
    if y[position] != x[position]:
        p_dif.append(position)
        # print(f"x =/= y at {position}") 
print(len(p_dif))

Path_1_Phg35 = [x[pos] for pos in p_dif]
print(len(Path_1_Phg35))
# print(f"The values at position {p} are {value}.")

Path_2_Phg35 = [y[pos] for pos in p_dif]
print(len(Path_2_Phg35))
# print(f"The values at position {p} are {value}.")

first_value = p_dif[0]
last_value = p_dif[-1]
print(f"The first value in the list is {first_value}.")
print(f"The last value in the list is {last_value}.")

fig, ax = plt.subplots(figsize=(15,5))
s = 0.5
ax.scatter(p_dif, Path_1_Phg35, s, c="blue", label="Path_1")
ax.scatter(p_dif, Path_2_Phg35, s, c="red", label="Path_2")


ax.set_xlabel("positions")
ax.set_ylabel("reads")
plt.legend(loc="upper left")
plt.title(f"Number of Reads P1 P2 against the position {first_value} to {last_value} of {Phage_name}")
plt.savefig("Number_of_Reads_P1_P2_against_position {first_value} to {last_value}.png", dpi=300, bbox_inches='tight', format="png")
