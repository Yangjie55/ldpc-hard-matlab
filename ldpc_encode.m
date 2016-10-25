function [u,P,rearranged_cols]=ldpc_encode(s,H)
%             ��˹��Ԫ
%��H=[A | B] ==========> [I | P]
%  u=[c | s]
%��  H*u' = u*H' = 0
%����ã�
%         _    _
%         | c' |
%  [I | P]|    | = 0
%         | s' |
%         -    -
%��I*c' + P*s' = 0
%��I*c' = P*s' (��GF(2)��)
%��  c' = P*s' 
%����u=[c | s]���ɵõ����������֡�
%�����˹��Ԫ�����н������н�����
%��ֻ���¼�н����������෴����Ա���������ͬ�������н������ɡ�
%����ʱ�����u���ٽ����н����õ�uu=[c | s]�����沿�ּ�����Ҫ����Ϣ��

dim=size(H);
rows=dim(1);
cols=dim(2);

[P,rearranged_cols]=H2P(H);%�õ�P�����Լ�ϵͳ�������е��б任

c=mul_GF2(P,s');

u=[c' s]; 

% u1=[c' s]; 

% u=reorder_bits(u1,rearranged_cols);%������
