beta_temp=abs(beta);
if beta<0
%     dx=-dx;
end
if beta_temp>max(beta_vec)
    beta_temp=max(beta_vec);
end
if beta_temp<min(beta_vec)
    beta_temp=min(beta_vec);
end
% if dx>max(dx_vec)
%     dx=max(dx_vec);
% end
% if dx<min(dx_vec)
%     dx=min(dx_vec);
% end
if num_dx>1
dx_cnt=1;
while(dx_cnt<num_dx)
if (dx>=dx_vec(dx_cnt)&&dx<=dx_vec(dx_cnt+1)||dx_cnt==num_dx-1)
    break;
end
   dx_cnt=dx_cnt+1; 
end

        for i1=1:num_beta
			for i2=1:num_Ma
				for i3=1:num_alpha
                    ca3(i1,i2,i3)=ca_dx(dx_cnt,i1,i2,i3)+(dx-dx_vec(dx_cnt))*(ca_dx(dx_cnt+1,i1,i2,i3)-ca_dx(dx_cnt,i1,i2,i3))/(dx_vec(dx_cnt+1)-dx_vec(dx_cnt));
                    cn3(i1,i2,i3)=cn_dx(dx_cnt,i1,i2,i3)+(dx-dx_vec(dx_cnt))*(cn_dx(dx_cnt+1,i1,i2,i3)-cn_dx(dx_cnt,i1,i2,i3))/(dx_vec(dx_cnt+1)-dx_vec(dx_cnt));
                    cz3(i1,i2,i3)=cz_dx(dx_cnt,i1,i2,i3)+(dx-dx_vec(dx_cnt))*(cz_dx(dx_cnt+1,i1,i2,i3)-cz_dx(dx_cnt,i1,i2,i3))/(dx_vec(dx_cnt+1)-dx_vec(dx_cnt));
                    mx3(i1,i2,i3)=mx_dx(dx_cnt,i1,i2,i3)+(dx-dx_vec(dx_cnt))*(mx_dx(dx_cnt+1,i1,i2,i3)-mx_dx(dx_cnt,i1,i2,i3))/(dx_vec(dx_cnt+1)-dx_vec(dx_cnt));
                    my3(i1,i2,i3)=my_dx(dx_cnt,i1,i2,i3)+(dx-dx_vec(dx_cnt))*(my_dx(dx_cnt+1,i1,i2,i3)-my_dx(dx_cnt,i1,i2,i3))/(dx_vec(dx_cnt+1)-dx_vec(dx_cnt));
                    mz3(i1,i2,i3)=mz_dx(dx_cnt,i1,i2,i3)+(dx-dx_vec(dx_cnt))*(mz_dx(dx_cnt+1,i1,i2,i3)-mz_dx(dx_cnt,i1,i2,i3))/(dx_vec(dx_cnt+1)-dx_vec(dx_cnt));
                end
            end
        end
else
    dx_cnt=1;
    for i1=1:num_beta
			for i2=1:num_Ma
				for i3=1:num_alpha
                    ca3(i1,i2,i3)=ca_dx(dx_cnt,i1,i2,i3);
                    cn3(i1,i2,i3)=cn_dx(dx_cnt,i1,i2,i3);
                    cz3(i1,i2,i3)=cz_dx(dx_cnt,i1,i2,i3);
                    mx3(i1,i2,i3)=mx_dx(dx_cnt,i1,i2,i3);
                    my3(i1,i2,i3)=my_dx(dx_cnt,i1,i2,i3);
                    mz3(i1,i2,i3)=mz_dx(dx_cnt,i1,i2,i3);
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