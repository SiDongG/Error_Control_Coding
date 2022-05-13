%Coded QPSK transmission in AWGN Using rate 1/2 convolutional code%
%Author Sidong Guo
clear;clc;close all;

n=4;
Block_Num=5000;
Bits=randi(0:1,[1,n,Block_Num]);
Rate=1/2;

Coded_bits=zeros([1,n/Rate,Block_Num]);
