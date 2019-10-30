This code is for inc-VAT, inc-iVAT, dec-VAT, and dec-iVAT algorithms described in the following paper:

D. Kumar, J. C. Bezdek, S. Rajasegarar, M. Palaniswami, C. Leckie, J. Chan, and J. Gubbi, “Adaptive cluster tendency visualization and anomaly detection for streaming data,” ACM Trans. Knowl. Discov. Data, vol. 11, no. 2, pp. 24:1–24:40, Dec. 2016.

Run "seq_iVAT_experiment_1.m" for the demo of changes in iVAT images as datasets keeps growing and then decresing. Output is stored in "ivat_image_movie_1.mp4" file which is generated in the same folder.

"seq_iVAT_experiment_2.m" is similar to "seq_iVAT_experiment_1.m," except input data is sorted according to the cluster they belong to better vsualize evolving cluster structure. Output is stored in "ivat_image_movie_2.mp4" file which is generated in the same folder.

"seq_iVAT_experiment_3.m" perform the time comparison analysis of inc-VAT, inc-iVAT, dec-VAT, and dec-iVAT vs VAT/iVAT.
