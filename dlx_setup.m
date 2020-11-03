function dlx_setup()
%DLX_SETUP 此处显示有关此函数的摘要
%   此处显示详细说明
global MAXN;
global MAX_COL;
global MAX_ROW;
global INT_INF;

INT_INF = int32(0x3f3f3f3f);
MAX_ROW = int32(9*9*9);
MAX_COL = int32(4*9*9);
MAXN = int32(9*9*9 * 4*9*9);

global left;
global right;
global up;
global down;
global row;
global column;
global rows;
global cols;
global maxnode;
global mustselect;
global tot;
global head;
global val;
global answer;
global a;
global top;

left = zeros(1, MAXN, 'int32');
right = zeros(1, MAXN, 'int32');
up = zeros(1, MAXN, 'int32');
down = zeros(1, MAXN, 'int32');
row = zeros(1, MAXN, 'int32');
column = zeros(1, MAXN, 'int32');
rows = int32(0);
cols = int32(0);
maxnode = int32(0);
mustselect = int32(0);
tot = zeros(1, MAX_COL, 'int32');
head = int32(0);
val = repmat(struct('x', 0, 'y', 0, 'num', 0), 1, MAX_ROW);
answer = repmat(struct('x', 0, 'y', 0, 'num', 0), 1, MAX_ROW);
a = zeros(1, MAX_COL, 'int32');
top = int32(0);
end

