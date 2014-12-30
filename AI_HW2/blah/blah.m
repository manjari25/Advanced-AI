clc;
clear all;
close all;
load ionosphere
tc = ClassificationTree.fit(features,targets);