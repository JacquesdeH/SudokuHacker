classdef Dlx
    %DLX Sudoku Improved DLX algorithm
    %   此处显示详细说明
    
    properties (Constant = true)
        INT_INF uint32 = uint32(0x3f3f3f3f);
        MAX_ROW(1,:) uint32 = uint32(9*9*9);
        MAX_COL(1,:) uint32 = uint32(4*9*9);
        MAXN(1,:) uint32 = uint32(9*9*9 * 4*9*9);
    end
    
    properties
        left(1,:) uint32
        right(1,:) uint32
        up(1,:) uint32
        down(1,:) uint32
        row(1,:) uint32
        column(1,:) uint32
        rows uint32
        cols uint32
        maxnode uint32
        mustselect uint32
        tot(1,:) uint32
        head uint32
        val
        answer
        a(1,:) uint32
        top uint32
    end
    
    methods
        function obj = Dlx()
            %DLX 构造此类的实例
            %   此处显示详细说明
            obj.left = zeros(1, obj.MAXN, 'uint32');
            obj.right = zeros(1, obj.MAXN, 'uint32');
            obj.up = zeros(1, obj.MAXN, 'uint32');
            obj.down = zeros(1, obj.MAXN, 'uint32');
            obj.row = zeros(1, obj.MAXN, 'uint32');
            obj.column = zeros(1, obj.MAXN, 'uint32');
            obj.rows = 0;
            obj.cols = 0;
            obj.maxnode = 0;
            obj.mustselect = 0;
            obj.tot = zeros(1, obj.MAX_COL, 'uint32');
            obj.head = 0;
            obj.val = repmat(struct('x', 0, 'y', 0, 'num', 0), 1, obj.MAX_ROW);
            obj.answer = repmat(struct('x', 0, 'y', 0, 'num', 0), 1, obj.MAX_ROW);
            obj.a = zeros(1, obj.MAX_COL, 'uint32');
            obj.top = 0;
        end
        
        function disable_row(obj, root)
            obj.left(obj.right(root+1)+1) = obj.left(root+1);
            obj.right(obj.left(root+1)+1) = obj.right(root+1);
        end
        
        function disable_col(obj, root)
            obj.up(obj.down(root+1)+1) = obj.up(root+1);
            obj.down(obj.up(root+1)+1) = obj.down(root+1);
        end
        
        function enable_row(obj, root)
            obj.left(obj.right(root+1)+1) = root;
            obj.right(obj.left(root+1)+1) = root;
        end
        
        function enable_col(obj, root)
            obj.up(obj.down(root+1)+1) = root;
            obj.down(obj.up(root+1)+1) = root;
        end
        
        function remove(obj, colnum)
            obj.disable_row(colnum);
            i = obj.down(colnum+1);
            while i ~= colnum
                j = obj.right(i+1);
                while j ~= i
                    obj.disable_col(j);
                    obj.tot(obj.column(j+1)) = obj.tot(obj.column(j+1)) - 1;
                    j = obj.right(j+1);
                end
                i = obj.down(i+1);
            end
        end
        
        function restore(obj, colnum)
            obj.enable_row(colnum);
            i = obj.up(colnum+1);
            while i ~= colnum
                j = obj.left(i+1);
                while j ~= i
                    obj.enable_col(j);
                    obj.tot(obj.column(j+1)) = obj.tot(obj.column(j+1)) + 1;
                    j = obj.left(j+1);
                end
                i = obj.up(i+1);
            end
        end
        
        function obj=initialize(obj)
            obj.left = zeros(1, obj.MAXN, 'uint32');
            obj.right = zeros(1, obj.MAXN, 'uint32');
            obj.up = zeros(1, obj.MAXN, 'uint32');
            obj.down = zeros(1, obj.MAXN, 'uint32');
            obj.row = zeros(1, obj.MAXN, 'uint32');
            obj.column = zeros(1, obj.MAXN, 'uint32');
            obj.tot = zeros(1, obj.MAX_COL, 'uint32');
            obj.rows = 0;
            obj.cols = obj.MAX_COL;
            obj.head = 0;
            obj.left(obj.head+1) = obj.cols;
            obj.right(obj.head+1) = 1;
            for i=1:obj.cols
                obj.left(i+1) = i-1;
                obj.right(i+1) = i+1;
                obj.up(i+1) = i;
                obj.down(i+1) = i;
                obj.row(i+1) = 0;
                obj.column(i+1) = i;
            end
            obj.right(obj.cols+1) = obj.head;
            obj.maxnode = obj.cols;
            obj.mustselect = 0;
        end
        
        function add_row(obj, cnt, info)
            obj.rows = obj.rows + 1;
            obj.val(obj.rows+1) = info;
            for i=1:cnt
                obj.maxnode = obj.maxnode + 1;
                obj.tot(obj.a(i)) = obj.tot(obj.a(i)) + 1;
                if i==1
                    obj.left(obj.maxnode+1) = obj.maxnode;
                    obj.right(obj.maxnode+1) = obj.maxnode;
                else
                    obj.left(obj.maxnode+1) = obj.maxnode - 1;
                    obj.right(obj.maxnode+1) = obj.right(obj.maxnode - 1+1);
                    obj.enable_row(obj.maxnode);
                end
                obj.up(obj.maxnode+1) = obj.up(obj.a(i)+1);
                obj.down(obj.maxnode+1) = obj.a(i);
                obj.enable_col(obj.maxnode);
                obj.column(obj.maxnode+1) = obj.a(i);
                obj.row(obj.maxnode+1) = obj.rows;
            end
        end
        
        function obj = insert_num(obj, i, j, num)
            N = idivide(i-1, 3, 'floor')*3 + idivide(j-1, 3, 'floor') + 1;
            obj.a(1) = (i-1)*9 + j;
            obj.a(2) = (i-1)*9 + num + 81;
            obj.a(3) = (j-1)*9 + num + 162;
            obj.a(4) = (N-1)*9 + num + 243;
            obj.add_row(4, struct('x', i, 'y', j, 'num', num));
            obj.answer(obj.mustselect+1) = obj.val(obj.rows+1);
            obj.mustselect = obj.mustselect + 1;
            for i=1:4
                obj.tot(obj.a(i)) = -1;
                obj.remove(obj.a(i));
            end
        end
        
        function insert_dot(obj, i, j)
            N = idivide(i-1, 3, 'floor')*3 + idivide(j-1, 3, 'floor') + 1;
            obj.a(1) = (i-1)*9 + j;
            obj.a(2) = (i-1)*9 + 81;
            obj.a(3) = (j-1)*9 + 162;
            obj.a(4) = (N-1)*9 + 243;
            for k=1:9
                obj.a(2) = obj.a(2) + 1;
                obj.a(3) = obj.a(3) + 1;
                obj.a(4) = obj.a(4) + 1;
                flag = uint8(1);
                for p=1:4
                    if obj.tot(obj.a(p)) == -1
                        flag = 0;
                    end
                end
                if flag == 1
                    obj.add_row(4, struct('x', i, 'y', j, 'num', k));
                end
            end
        end
        
        function [obj, ret] = Dance(obj, k)
            c1 = obj.right(obj.head+1);
            if c1 == obj.head
                obj.top = k;
                ret = 1;
                return;
            end
            i = obj.right(c1+1);
            while i ~= obj.head
                if obj.tot(i) < obj.tot(c1)
                    c1 = i;
                end
                if obj.tot(i) ~= 0
                    ret = 0;
                    return;
                end
                i = obj.right(i+1);
            end
            obj.remove(c1);
            i = obj.down(c1+1);
            while i ~= c1
                obj.answer(k+1) = obj.val(obj.row(i+1)+1);
                j = obj.right(i+1);
                while j ~= i
                    obj.remove(obj.column(j+1));
                    j = obj.right(j+1);
                end
                if obj.Dance(k+1) == 1
                    ret = 1;
                    return;
                end
                j = obj.left(i+1);
                while j ~= i
                    obj.restore(obj.column(j+1));
                    j = obj.left(j+1);
                end
                i = obj.down(i+1);
            end
            obj.restore(c1);
            ret = 0;
            return;
        end
        
        function retMatrix = run(obj, sudoMatrix)
            % run with sudoMatrix of size 9x9
            obj.initialize();
            for i=1:9
                for j=1:9
                    if sudoMatrix(i, j) ~= 0
                        obj.insert_num(uint32(i), uint32(j), sudoMatrix(i, j));
                    end
                end
            end
            for i=1:9
                for j=1:9
                    if sudoMatrix(i, j) == 0
                        obj.insert_dot(uint32(i), uint32(j));
                    end
                end
            end
            obj.Dance(obj.mustselect);
            G = zeros(9, 9, 'uint32');
            for i=0:obj.top
                G(obj.answer(i+1).x+1, obj.answer(i+1).y+1) = obj.answer(i+1).num;
            end
            retMatrix = G;
        end
    end
end

