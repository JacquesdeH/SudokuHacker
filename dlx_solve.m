function retMatrix = dlx_solve(sudoMatrix)
            % Use dlx_solve() to call algorithm
            % Taking input as 9x9 matrix with uint32 as type
            % Giving output as 9x9 matrix with uint32 as type
            global mustselect;
            global answer;
            global top;
            
            dlx_setup();
            initialize();
            for i=1:9
                for j=1:9
                    if sudoMatrix(i, j) ~= 0
                        insert_num(int32(i), int32(j), int32(sudoMatrix(i, j)));
                    end
                end
            end
            for i=1:9
                for j=1:9
                    if sudoMatrix(i, j) == 0
                        insert_dot(int32(i), int32(j));
                    end
                end
            end
            Dance(mustselect);
            G = sudoMatrix;
            for i=0:(top-1)
                G(answer(i+1).x+1, answer(i+1).y+1) = answer(i+1).num;
            end
            retMatrix = G(2:10, 2:10);
        end

        
%inputMatrix = [0,2,7,3,8,0,0,1,0; 0,1,0,0,0,6,7,3,5; 0,0,0,0,0,0,0,2,9; 3,0,5,6,9,2,0,8,0; 0,0,0,0,0,0,0,0,0; 0,6,0,1,7,4,5,0,3; 6,4,0,0,0,0,0,0,0; 9,5,1,8,0,0,0,7,0; 0,8,0,0,6,5,3,4,0];
%outputMatrix = dlx_run(inputMatrix);
%disp(outputMatrix);
        
        function disable_row(root)
            global left;
            global right;
            left(right(root+1)+1) = left(root+1);
            right(left(root+1)+1) = right(root+1);
        end
        
        function disable_col(root)
            global up;
            global down;
            up(down(root+1)+1) = up(root+1);
            down(up(root+1)+1) = down(root+1);
        end
        
        function enable_row(root)
            global left;
            global right;
            left(right(root+1)+1) = root;
            right(left(root+1)+1) = root;
        end
        
        function enable_col(root)
            global up;
            global down;
            up(down(root+1)+1) = root;
            down(up(root+1)+1) = root;
        end
        
        function remove(colnum)
            global right;
            global down;
            global column;
            global tot;
            disable_row(colnum);
            i = down(colnum+1);
            while i ~= colnum
                j = right(i+1);
                while j ~= i
                    disable_col(j);
                    tot(column(j+1)) = tot(column(j+1)) - 1;
                    j = right(j+1);
                end
                i = down(i+1);
            end
        end
        
        function restore(colnum)
            global left;
            global up;
            global column;
            global tot;
            enable_row(colnum);
            i = up(colnum+1);
            while i ~= colnum
                j = left(i+1);
                while j ~= i
                    enable_col(j);
                    tot(column(j+1)) = tot(column(j+1)) + 1;
                    j = left(j+1);
                end
                i = up(i+1);
            end
        end
        
        function initialize()
            global MAXN;
            global MAX_COL;
            
            global left;
            global right;
            global up;
            global down;
            global row;
            global column;
            global tot;
            global rows;
            global cols;
            global head;
            global maxnode;
            global mustselect;
            
            left = zeros(1, MAXN, 'int32');
            right = zeros(1, MAXN, 'int32');
            up = zeros(1, MAXN, 'int32');
            down = zeros(1, MAXN, 'int32');
            row = zeros(1, MAXN, 'int32');
            column = zeros(1, MAXN, 'int32');
            tot = zeros(1, MAX_COL, 'int32');
            rows = 0;
            cols = MAX_COL;
            head = 0;
            left(head+1) = cols;
            right(head+1) = 1;
            for i=1:cols
                left(i+1) = i-1;
                right(i+1) = i+1;
                up(i+1) = i;
                down(i+1) = i;
                row(i+1) = 0;
                column(i+1) = i;
            end
            right(cols+1) = head;
            maxnode = cols;
            mustselect = 0;
        end
        
        function add_row(cnt, info)
            global left;
            global right;
            global up;
            global down;
            global row;
            global column;
            global tot;
            global rows;
            global maxnode;
            global val;
            global a;
            rows = rows + 1;
            val(rows+1) = info;
            for i=1:cnt
                maxnode = maxnode + 1;
                tot(a(i)) = tot(a(i)) + 1;
                if i==1
                    left(maxnode+1) = maxnode;
                    right(maxnode+1) = maxnode;
                else
                    left(maxnode+1) = maxnode - 1;
                    right(maxnode+1) = right(maxnode - 1+1);
                    enable_row(maxnode);
                end
                up(maxnode+1) = up(a(i)+1);
                down(maxnode+1) = a(i);
                enable_col(maxnode);
                column(maxnode+1) = a(i);
                row(maxnode+1) = rows;
            end
        end
        
        function insert_num(i, j, num)
            global tot;
            global rows;
            global mustselect;
            global answer;
            global val;
            global a;
            N = idivide(i-1, 3, 'floor')*3 + idivide(j-1, 3, 'floor') + 1;
            a(1) = (i-1)*9 + j;
            a(2) = (i-1)*9 + num + 81;
            a(3) = (j-1)*9 + num + 162;
            a(4) = (N-1)*9 + num + 243;
            add_row(4, struct('x', i, 'y', j, 'num', num));
            answer(mustselect+1) = val(rows+1);
            mustselect = mustselect + 1;
            for i=1:4
                tot(a(i)) = -1;
                remove(a(i));
            end
        end
        
        function insert_dot(i, j)
            global tot;
            global a;
            N = idivide(i-1, 3, 'floor')*3 + idivide(j-1, 3, 'floor') + 1;
            a(1) = (i-1)*9 + j;
            a(2) = (i-1)*9 + 81;
            a(3) = (j-1)*9 + 162;
            a(4) = (N-1)*9 + 243;
            for k=1:9
                a(2) = a(2) + 1;
                a(3) = a(3) + 1;
                a(4) = a(4) + 1;
                flag = uint8(1);
                for p=1:4
                    if tot(a(p)) == -1
                        flag = 0;
                    end
                end
                if flag == 1
                    add_row(4, struct('x', i, 'y', j, 'num', k));
                end
            end
        end
        
        function [ret] = Dance(k)
            global left;
            global right;
            global down;
            global row;
            global column;
            global tot;
            global head;
            global answer;
            global val;
            global top;
            c1 = right(head+1);
            if c1 == head
                top = k;
                ret = 1;
                return;
            end
            i = right(c1+1);
            while i ~= head
                if tot(i) < tot(c1)
                    c1 = i;
                end
                if tot(i) == 0
                    ret = 0;
                    return;
                end
                i = right(i+1);
            end
            remove(c1);
            i = down(c1+1);
            while i ~= c1
                answer(k+1) = val(row(i+1)+1);
                j = right(i+1);
                while j ~= i
                    remove(column(j+1));
                    j = right(j+1);
                end
                if Dance(k+1) == 1
                    ret = 1;
                    return;
                end
                j = left(i+1);
                while j ~= i
                    restore(column(j+1));
                    j = left(j+1);
                end
                i = down(i+1);
            end
            restore(c1);
            ret = 0;
            return;
        end
        
        
       
