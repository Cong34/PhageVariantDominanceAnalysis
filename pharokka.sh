#!/bin/bash

paths=('phage_comp_5' 'phage_comp_10' 'phage_comp_21' 'phage_comp_24' 'phage_comp_26' 'phage_comp_27' 'phage_comp_28' 'phage_comp_31' 'phage_comp_45' 'phage_comp_46' 'phage_comp_65' 'phage_comp_73' 'phage_comp_76' 'phage_comp_86' 'phage_comp_87' 'phage_comp_93' 'phage_comp_105' 'phage_comp_122' 'phage_comp_142')

for component in "${paths[@]}"; do
    mkdir -p ~/Annotation/ ~/Annotation/${component}_annotation
    for i in {1..6}; do
        if [ -f PHAGE_BUBBLE/Paths/${component}_file/${component}_cycle_$i.fasta ]; then
            pharokka.py -i ~/PHAGE_BUBBLE/Paths/${component}_file/${component}_cycle_$i.fasta -o ~/Annotation/${component}_annotation/${component}_path_$i -d ~/Pharokka_annotation -t 8
            pharokka_plotter.py -i ~/PHAGE_BUBBLE/Paths/${component}_file/${component}_cycle_$i.fasta -n pharokka_plot -o ~/Annotation/${component}_annotation/${component}_path_$i
        fi
    done
done



# mkdir -p ~/Pharokka_annotation/phage_comp_5_annotation
# pharokka.py -i ~/PHAGE_BUBBLE/Paths/phage_comp_5_file/phage_comp_5_cycle_1.fasta -o ~/Pharokka_annotation/phage_comp_5_annotation/phage_comp_5_path_1 -d ~/Pharokka_annotation -t 8
# pharokka_plotter.py -i ~/PHAGE_BUBBLE/Paths/phage_comp_5_file/phage_comp_5_cycle_1.fasta -n pharokka_plot -o ~/Pharokka_annotation/phage_comp_5_annotation/phage_comp_5_path_1


# for component in "${paths[@]}"; do
#     for i in {1..6}; do 
#         if [ ! -e "PHAGE_BUBBLE/Paths/${component}_file/${component}_cycle_$i.fasta" ]; then
#             echo "${component}_cycle_$i.fasta exists."
#         else
#             echo "Error"
#         fi
#     done
# done


