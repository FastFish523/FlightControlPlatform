beta_temp=abs(beta);
if beta<0
%     dy=-dy;
end
if beta_temp>max(beta_vec)
    beta_temp=max(beta_vec);
end
if beta_temp<min(beta_vec)
    beta_temp=min(beta_vec);
end
% if dy>max(dy_vec)
%     dy=max(dy_vec);
% end
% if dy<min(dy_vec)
%     dy=min(dy_vec);
% end
if num_dy>1
dy_cnt=1;
while(dy_cnt<num_dy)
if (dy>=dy_vec(dy_cnt)&&dy<=dy_vec(dy_cnt+1)||dy_cnt==num_dy-1)
    break;
end
   dy_cnt=dy_cnt+1; 
end

        for i1=1:num_beta
			for i2=1:num_Ma
				for i3=1:num_alpha
                    ca3(i1,i2,i3)=ca_dy(dy_cnt,i1,i2,i3)+(dy-dy_vec(dy_cnt))*(ca_dy(dy_cnt+1,i1,i2,i3)-ca_dy(dy_cnt,i1,i2,i3))/(dy_vec(dy_cnt+1)-dy_vec(dy_cnt));
                    cn3(i1,i2,i3)=cn_dy(dy_cnt,i1,i2,i3)+(dy-dy_vec(dy_cnt))*(cn_dy(dy_cnt+1,i1,i2,i3)-cn_dy(dy_cnt,i1,i2,i3))/(dy_vec(dy_cnt+1)-dy_vec(dy_cnt));
                    cz3(i1,i2,i3)=cz_dy(dy_cnt,i1,i2,i3)+(dy-dy_vec(dy_cnt))*(cz_dy(dy_cnt+1,i1,i2,i3)-cz_dy(dy_cnt,i1,i2,i3))/(dy_vec(dy_cnt+1)-dy_vec(dy_cnt));
                    mx3(i1,i2,i3)=mx_dy(dy_cnt,i1,i2,i3)+(dy-dy_vec(dy_cnt))*(mx_dy(dy_cnt+1,i1,i2,i3)-mx_dy(dy_cnt,i1,i2,i3))/(dy_vec(dy_cnt+1)-dy_vec(dy_cnt));
                    my3(i1,i2,i3)=my_dy(dy_cnt,i1,i2,i3)+(dy-dy_vec(dy_cnt))*(my_dy(dy_cnt+1,i1,i2,i3)-my_dy(dy_cnt,i1,i2,i3))/(dy_vec(dy_cnt+1)-dy_vec(dy_cnt));
                    mz3(i1,i2,i3)=mz_dy(dy_cnt,i1,i2,i3)+(dy-dy_vec(dy_cnt))*(mz_dy(dy_cnt+1,i1,i2,i3)-mz_dy(dy_cnt,i1,i2,i3))/(dy_vec(dy_cnt+1)-dy_vec(dy_cnt));
                end
            end
        end
else
    dy_cnt=1;
    for i1=1:num_beta
			for i2=1:num_Ma
				for i3=1:num_alpha
                    ca3(i1,i2,i3)=ca_dy(dy_cnt,i1,i2,i3);
                    cn3(i1,i2,i3)=cn_dy(dy_cnt,i1,i2,i3);
                    cz3(i1,i2,i3)=cz_dy(dy_cnt,i1,i2,i3);
                    mx3(i1,i2,i3)=mx_dy(dy_cnt,i1,i2,i3);
                    my3(i1,i2,i3)=my_dy(dy_cnt,i1,i2,i3);
                    mz3(i1,i2,i3)=mz_dy(dy_cnt,i1,i2,i3);
                end
            end
        end
end
if num_beta>1
beta_cnt=1;
while(beta_cnt<num_beta)
if (beta_temp>=beta_vec(beta_cnt)&&beta_temp<=beta_vec(beta_cnt+1))
    break;
end
   beta_cnt=beta_cnt+1; 
end
            for i2=1:num_Ma
				for i3=1:num_alpha
                    a(i2,i3)=ca3(beta_cnt,i2,i3)+(beta_temp-beta_vec(beta_cnt))*(ca3(beta_cnt+1,i2,i3)-ca3(beta_cnt,i2,i3))/(beta_vec(beta_cnt+1)-beta_vec(beta_cnt));
                    n(i2,i3)=cn3(beta_cnt,i2,i3)+(beta_temp-beta_vec(beta_cnt))*(cn3(beta_cnt+1,i2,i3)-cn3(beta_cnt,i2,i3))/(beta_vec(beta_cnt+1)-beta_vec(beta_cnt));
                    if beta>=0
                        z(i2,i3)=(cz3(beta_cnt,i2,i3)+(beta_temp-beta_vec(beta_cnt))*(cz3(beta_cnt+1,i2,i3)-cz3(beta_cnt,i2,i3))/(beta_vec(beta_cnt+1)-beta_vec(beta_cnt)));
                        gz(i2,i3)=(mx3(beta_cnt,i2,i3)+(beta_temp-beta_vec(beta_cnt))*(mx3(beta_cnt+1,i2,i3)-mx3(beta_cnt,i2,i3))/(beta_vec(beta_cnt+1)-beta_vec(beta_cnt)));
                        ph(i2,i3)=(my3(beta_cnt,i2,i3)+(beta_temp-beta_vec(beta_cnt))*(my3(beta_cnt+1,i2,i3)-my3(beta_cnt,i2,i3))/(beta_vec(beta_cnt+1)-beta_vec(beta_cnt)));
                    else
                        z11(i2,i3)=(cz3(beta_cnt,i2,i3)+(beta_temp-beta_vec(beta_cnt))*(cz3(beta_cnt+1,i2,i3)-cz3(beta_cnt,i2,i3))/(beta_vec(beta_cnt+1)-beta_vec(beta_cnt)));
                        gz11(i2,i3)=(mx3(beta_cnt,i2,i3)+(beta_temp-beta_vec(beta_cnt))*(mx3(beta_cnt+1,i2,i3)-mx3(beta_cnt,i2,i3))/(beta_vec(beta_cnt+1)-beta_vec(beta_cnt)));
                        ph11(i2,i3)=(my3(beta_cnt,i2,i3)+(beta_temp-beta_vec(beta_cnt))*(my3(beta_cnt+1,i2,i3)-my3(beta_cnt,i2,i3))/(beta_vec(beta_cnt+1)-beta_vec(beta_cnt)));
                        
                        z22(i2,i3)=cz3(1,i2,i3);
                        gz22(i2,i3)=mx3(1,i2,i3);
                        ph22(i2,i3)=my3(1,i2,i3);
                        
                        z(i2,i3)=2*z22(i2,i3)-z11(i2,i3);
                        gz(i2,i3)=2*gz22(i2,i3)-gz11(i2,i3);
                        ph(i2,i3)=2*ph22(i2,i3)-ph11(i2,i3);
                    end
                    fy(i2,i3)=mz3(beta_cnt,i2,i3)+(beta_temp-beta_vec(beta_cnt))*(mz3(beta_cnt+1,i2,i3)-mz3(beta_cnt,i2,i3))/(beta_vec(beta_cnt+1)-beta_vec(beta_cnt));
                end
            end
else
    beta_cnt=1;
    for i2=1:num_Ma
				for i3=1:num_alpha
                    a(i2,i3)=ca3(beta_cnt,i2,i3);
                    n(i2,i3)=cn3(beta_cnt,i2,i3);
                    if beta>=0
                        z(i2,i3)=(cz3(beta_cnt,i2,i3));
                        gz(i2,i3)=(mx3(beta_cnt,i2,i3));
                        ph(i2,i3)=(my3(beta_cnt,i2,i3));
                    else
                        z11(i2,i3)=(cz3(beta_cnt,i2,i3));
                        gz11(i2,i3)=(mx3(beta_cnt,i2,i3));
                        ph11(i2,i3)=(my3(beta_cnt,i2,i3));

                        z22(i2,i3)=(cz3(1,i2,i3));
                        gz22(i2,i3)=(mx3(1,i2,i3));
                        ph22(i2,i3)=(my3(1,i2,i3));

                        z(i2,i3)=2*z22(i2,i3)-z11(i2,i3);
                        gz(i2,i3)=2*gz22(i2,i3)-gz11(i2,i3);
                        ph(i2,i3)=2*ph22(i2,i3)-ph11(i2,i3);
                    end
                    fy(i2,i3)=mz3(beta_cnt,i2,i3);
                end
            end
end
a=-a;