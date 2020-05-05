rsplit


Split a file into 250MB chunks:

    cat big_file | rsplit.rb 250 big_file_part_
    
    => big_file_part_01,
       big_file_part_02,
       ...

Re-split into 1GB chunks:

    cat big_file_part* | rsplit.rb 1000 big_file_in_1gchunks_


-- BH, Dec 2014

