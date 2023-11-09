#!bin/bash
cd

# Components that was used in the study: 
paths=('phage_comp_5' 'phage_comp_10' 'phage_comp_21' 'phage_comp_24' 'phage_comp_26' 'phage_comp_27' 'phage_comp_28' 'phage_comp_31' 'phage_comp_45' 'phage_comp_46' 'phage_comp_65' 'phage_comp_73' 'phage_comp_76' 'phage_comp_86' 'phage_comp_87' 'phage_comp_93' 'phage_comp_105' 'phage_comp_122' 'phage_comp_142')
# Patients that was selected in the study: 
patient_ID_list=("230_4" "282" "1012A" "2093A" "2028A" "2037A" "2064A" "2065A" "228" "203" "2036A" "2032A" "2056A" "2057A" "2066A" "234" "268")

# make all the directories: Sam, Bam and Patient_sample (bam sorted)
mkdir -p /scratch/user/pham0323/Time_series/ /scratch/user/pham0323/Time_series/sam /scratch/user/pham0323/Time_series/bam /scratch/user/pham0323/Time_series/Patient_sample

for id in "${patient_ID_list[@]}"; do
    mkdir /scratch/user/pham0323/Time_series/Patient_sample/$id
    for component in "${paths[@]}"; do
        mkdir /scratch/user/pham0323/Time_series/Patient_sample/$id/$component
        while IFS= read -r line; do
            echo $id
            echo $line
            echo $component
            minimap2 -ax sr -t 16 --secondary=no ~/PHAGE_BUBBLE/Paths/$component"_file"/$component"_combined_file.fasta" /scratch/user/pham0323/reads/$line"_R1_001.fastq.gz" /scratch/user/pham0323/reads/$line"_R2_001.fastq.gz" > /scratch/user/pham0323/Time_series/sam/$id"_"$component"_"$line"_all_paths.sam"
            echo done
            
            samtools view -b -S -@ 16 /scratch/user/pham0323/Time_series/sam/$id"_"$component"_"$line"_all_paths.sam" > /scratch/user/pham0323/Time_series/bam/$id"_"$component"_"$line"_all_paths.bam"
            samtools sort -@ 16 /scratch/user/pham0323/Time_series/bam/$id"_"$component"_"$line"_all_paths.bam" -o /scratch/user/pham0323/Time_series/Patient_sample/$id/$component/$line"_all_paths_sorted.bam"
            samtools index -@ 16 /scratch/user/pham0323/Time_series/Patient_sample/$id/$component/$line"_all_paths_sorted.bam"
            
            rm /scratch/user/pham0323/Time_series/sam/* /scratch/user/pham0323/Time_series/bam/*
            
        done < ~/Time_series/Sample_output/$id"_sample_output.txt"
    done
done

minimap2 -ax sr -t 16 --secondary=no Phage_genome_ file Metagenome_forward Metagenome_backward > Sam_file
samtools view -b -S -@ 16 Sam_file > Bam_file
samtools sort -@ 16 Bam_file > Bam_file_sorted 
samtool index -@ 16 Bam_file_sorted
