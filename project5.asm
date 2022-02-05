#Data segment
	.data
#Bien
point_0:	.word	0
point_1:	.word	0
ban_co: .word	1000,5,5,5,5,5
        .word	1000,5,5,5,5,5
No.10: .word 10
#Cau nhac
gach1: .asciiz "\t+----+----+----+----+----+----+----+\n"
gach2: .asciiz "\t| 00 | 05 | 05 | 05 | 05 | 05 | 00 |\n"
gach3: .asciiz "\t|    +----+----+----+----+----+    |\n"
gach4: .asciiz "\t| 01 | 05 | 05 | 05 | 05 | 05 | 01 |\n"	       
gach5: .asciiz "\t+----+----+----+----+----+----+----+\n"
player_0:	.space 100
player_1:	.space 100
nhap_o: 		.asciiz "Nhap o ban chon: "
nhap_huong:	.asciiz	"Nhap huong: "
nhap_o_sai:	.asciiz "Ban chi co the chon o tu 1-5 !!"
nhap_huong_sai:	.asciiz "Ban chi co the chon huong la 0 hoac 1 !!"
nhap_o_trong:	.asciiz "Khong the chon o trong !!"
luot:		.asciiz	"Luot cua "
in_ket_qua:	.asciiz "Ket qua la: \n"
in_winner:	.asciiz "\nNguoi chien thang la: "
in_hoa:		.asciiz "\nHoa nhau"
in_vay:		.asciiz "Khong co quan nen ban phai vay\nBan co sau khi vay \n"
in_choi_lai:	.asciiz "\nChoi lai chon 0 hoac 1 de thoat "
in_diem_hien_tai: .asciiz "\tDiem hien tai: "
ngan_cach:	.asciiz " : "
nhap_ten_0:	.asciiz "Nhap ten nguoi choi 1: "
nhap_ten_1:	.asciiz "Nhap ten nguoi choi 2: "
# Luat choi
Ten_tro_choi: 	.asciiz " Tro choi: O AN QUAN\n"
Luat_0: 	.asciiz	" - Gioi thieu:\n + Ban co gom 2 o quan và 10 o dan (1 quan tuong ung voi 10 dan), 5 o duoi la cua nguoi choi 1, 5 o tren la cua nguoi choi 2\n"
Luat_1:		.asciiz " + 2 o quan se gom 2 so de hien thi, so o duoi chi mang 2 gia tri 0 hoac 1 (0: khong con quan, 1: con quan), so o tren the hien so\n dan dang o trong o quan\n"
Luat_2:		.asciiz " - Cach choi:\n"
Luat_3:		.asciiz " + Ban dau nguoi choi se chon vi tri de rai, co pham vi tu 1 den 5 tuong ung voi cac o dan tinh tu trai sang phai\n"
Luat_4:		.asciiz " + Chon huong rai: nhap 1 se rai nguoc chieu kim dong ho, nhap 0 se rai cung chieu kim dong ho\n"
ban_co_ban_dau: .asciiz "\t+----+----+----+----+----+----+----+\n\t| 00 | 05 | 05 | 05 | 05 | 05 | 00 |\n\t|    +----+----+----+----+----+    |\n\t| 01 | 05 | 05 | 05 | 05 | 05 | 01 |\n\t+----+----+----+----+----+----+----+\n"
bat_dau: 	.asciiz " - Bat dau tro choi:\n"
#Code segmentciiz 
	.text
	.globl	main
main:
#------------------------------------
#hien thi luat choi
	la $a0,Ten_tro_choi
	li $v0,4
	syscall
	la $a0,Luat_0
	li $v0,4
	syscall
	la $a0,ban_co_ban_dau
	li $v0,4
	syscall
	la $a0,Luat_1
	li $v0,4
	syscall
	la $a0,Luat_2
	li $v0,4
	syscall
	la $a0,Luat_3
	li $v0,4
	syscall
	la $a0,Luat_4
	li $v0,4
	syscall	
	la $a0,bat_dau
	li $v0,4
	syscall	
#------------------------------------
#nhap	
#-------------------
# nhap ten 0
	la $a0, nhap_ten_0
	addi $v0, $zero, 4
	syscall
	
	la $a0, player_0
	addi $a1, $zero, 100
	addi $v0, $zero, 8
	syscall
# nhap ten 1
	la $a0, nhap_ten_1
	addi $v0, $zero, 4
	syscall
	
	la $a0, player_1
	addi $a1, $zero, 100
	addi $v0, $zero, 8
	syscall
# hien thi ban co
	jal print
#-------------------

#xu li
#bat dau tro choi
start:
#khoi tao s0=0
	addi $s0, $zero, 0
enter:
#s0 chua luot cua nguoi choi 0 hoac 1
  # dk_0
	la $a0, luot
	addi $v0, $zero, 4
	syscall
	
	beq $s0, $zero, else_0
 #luot cua nguoi choi 1
if_0:	
	la $a0, player_1
	addi $v0, $zero, 4
	syscall
	j out_0
 #luot cua nguoi choi 0
else_0:	
	la $a0, player_0
	addi $v0, $zero, 4
	syscall
out_0:
#--------------------------------------------
#--------------------------------------
# kiem tra xem co can muon quan hay khong
# goi ham
	add $a1, $zero, $s0
	jal check_to_borrow
#dk_25
	beq $v0, $zero, if_25
# vo=1 => muon
	la $a0, in_vay
	addi $v0, $zero, 4
	syscall
	
	jal print
if_25:
#v0=0 => khong muon
#--------------------------------------
nhap_o_huong:
#nhap o, nhap huong
#t0 chua o, t1 chua huong
#nhap o

	la $a0, nhap_o
	addi $v0, $zero, 4
	syscall
		
	addi $v0, $zero, 5
	syscall
	add $t0, $zero, $v0
#nhap huong
	la $a0, nhap_huong
	addi $v0, $zero, 4
	syscall
	
	addi $v0, $zero, 5
	syscall
	add $t1, $zero, $v0
#----------------------------------------------------
#----------------------------------------------------
#kiem tra co hop le
# goi ham
	add $a1, $zero, $s0
	add $a2, $zero, $t0
	add $a3, $zero, $t1
	jal check_pos
# v0=1 =>hop le, v0=0 =>o sai, v0=2 => huong sai
	addi $t3, $zero, 1	
	beq $v0, $t3, out_2_2
	bne $v0, $zero, out_2_1
# in cau xuat o sai v0=1
	la $a0, nhap_o_sai
	addi $v0, $zero, 4
	syscall
	j out_2_3
out_2_1: # v0=2
# in cau xuat huong sai
	la $a0, nhap_huong_sai
	addi $v0, $zero, 4
	syscall
out_2_3:
# in xuong dong	
	addi $a0, $zero, '\n'
	addi $v0, $zero, 11
	syscall
	
	j nhap_o_huong
#vi_tri_thoa
out_2_2:
#-------------------------------------------
# chuyen doi t0 cho phu hop voi code 
#dk_40:
	beq $s0, $zero, if_40
#luot cua player_1 => chuyen doi
	addi $t2, $zero, 12
	sub $t0, $t2, $t0
if_40:
#luot cua player_0 => khong can lam gi
#-------------------------------------------
# kiem tra xem co trong hay khong
	la $a0, ban_co
	sll $t2, $t0, 2
	add $a0, $a0, $t2
	lw $t2, 0($a0)
	bne $t2, $zero,khong_trong
# in cau xuat sai
	la $a0, nhap_o_trong
	addi $v0, $zero, 4
	syscall
# in xuong dong	
	addi $a0, $zero, '\n'
	addi $v0, $zero, 11
	syscall
	
	j nhap_o_huong
khong_trong:
#-----------------------------------------------------

#-----------------------------------------------------
# cap nhat ban co
 # rai quan
 	add $a1, $s0, $zero
 	add $a2, $t0, $zero
 	add $a3, $t1, $zero
 	jal updateBoard
# tra ve
	add $t2, $zero, $v0
#-----------------------------------------------------

#----------------------------------
# kiem tra dk ket thuc
#t2=2 => ket thuc tro choi
	addi $t3, $zero, 2
	beq $t2, $t3, in_ket_qua_tro_choi
#t2=1 => doi luot
#dk_19
	beq $s0, $zero, if_19
	addi $s0, $zero, 0
	j else_19
if_19:
	addi $s0, $zero, 1
else_19:
	j enter
#----------------------------------	
			
# xuat
in_ket_qua_tro_choi:
	jal print_result
# choi lai
	la $a0, in_choi_lai
	addi $v0, $zero, 4
	syscall
	
	addi $v0, $zero, 5
	syscall
# dk_27
	bne $v0, $zero, exit
	jal reset
	j main
	
#exit
exit:
	addi $v0,$zero,10
	syscall
#-----------------------------------------------------------
#------------------end_main--------------------------------
#----------------------------------------------------------
#----------------------------------------------------------
#----------------check_pos-----------------------------------
#-----------------------------------------------------------
check_pos:
#a1 =s0 chua luot, a2 chua o, a3 chua huong
# luu gia tri t0 t1 vao stack
	addi $sp, $sp, -8
	sw $t0, 4($sp)
	sw $t1, 0($sp)	
#------------------kiem tra o----------------------
 #   1<= a2 <=5 <=> not(a2<1) && a2<6
 #a2=a2-1
 	addi $a2, $a2, -1
	slt $t0, $a2, $zero
	xori $t0, 1
 #a2=a2-5
 	addi $a2, $a2, -5
 	slt $t1, $a2, $zero
 # gtr tra ve t0
 	and $t0, $t0, $t1
 # phuc hoi a2 	a2=a2+6
 	addi $a2, $a2, 6 
  #kiem tra xem t0 co bang 0
  # neu khong hop le tra ve gia tri =0 la khong thoa
 	beq $t0, $zero, out_check_pos	
#-------------------kiem tra huong--------------------
# a3=0 || a3=1 <=> not(a3<0) && a3<2
# not(a3<0)
	slt $t1, $a3, $zero
	xori $t1, 1
	and $t0, $t1, $t0
# a3<2 <=> a3-2<0
	addi $a3, $a3, -2
	slt $t1, $a3, $zero
	and $t0, $t1, $t0
# phuc hoi gia tri a3
	addi $a3, $a3, 2
# kiem tra xem co thoa khong
# neu bang 1 => thoa
	bne $t0, $zero, out_check_pos
# khong thoa => tra ve 2
	addi $t0, $zero, 2
out_check_pos:
#tra ve
	add $v0, $zero, $t0
# tra gia tri t0, t1 tu stack
	lw $t0, 4($sp)
	lw $t1, 0($sp)
	addi $sp, $sp, 8
	
	jr $ra
#----------------------------------------------------------
#---------------------end_funct----------------------------
#----------------------------------------------------------
#----------------------------------------------------------
#---------------------updateBoard--------------------------
#----------------------------------------------------------
updateBoard:
# a1 chua nguoi choi, $a2 chua o duoc chon, $a3 chua huong
# luu gia tri t0 t1 t2 vao stack
	addi $sp, $sp, -16
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	sw $t2, 8($sp)
	sw $t3, 12($sp)
																														
# t0 se luu vi tri hien tai
	add $t0, $zero, $a2
rai_quan:
# t1 se luu so quan dang rai
# t2 la bien
	la $a0, ban_co
	sll $t2, $t0, 2
	add $a0, $a0, $t2
	lw $t1, 0($a0)
	sw $zero, 0($a0)
# vong lap while: rai het t1
while_0:
#------------kiem tra huong va thay doi vi tri----------------
#dk3
	beq $a3, $zero, if_3
# a3=1 =>nguoc chieu kim dong ho
	addi $t0, $t0, 1
# so sanh t0 voi 12
	addi $t2, $zero, 12
#dk4
	bne $t0, $t2, else_3
# t0=12 => reset t0=0
	addi $t0, $zero, 0
	j else_3
	
if_3:
# a3=0 =>cung chieu kim dong ho
	addi $t0, $t0, -1
# so sanh t0 voi -1
	addi $t2, $zero, -1
# dk5
	bne $t0, $t2, else_3
# t0=-1 => reset t0=11
	addi $t0, $zero, 11
else_3:
#----------------------------------------------
# cap nhat gia tri tai o t0
	la $a0, ban_co
	sll $t2, $t0, 2
	add $a0, $a0, $t2
	lw $t2, 0($a0)
	addi $t2, $t2, 1
	sw $t2, 0($a0)
# kiem tra xem rai het quan chua
	addi $t1, $t1, -1
	bne $t1, $zero, while_0
		
#------------------kiem tra co dung khong--------------

# truyen tham so a1 chua nguoi choi, $a2 chua o hien tai, $a3 chua huong
	add $a1, $zero, $s0	
	add $a2, $t0, $zero
# goi ham
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal checkTerminate
	lw $ra, 0($sp)
	addi $sp, $sp, 4	
# lay gia tri luu vao t2
	add $t2, $zero, $v0
#-------------------------------------------------------
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal print
	lw $ra, 0($sp)
	addi $sp, $sp, 4
#------------kiem tra--------------------------
#t2=0 => tiep tuc rai
#-----------tang gia tri cua o hien tai----------------
#dk30
	beq $a3, $zero, if_30
# a3=1 =>nguoc chieu kim dong ho
	addi $t0, $t0, 1
# so sanh t0 voi t3
	addi $t3, $zero, 12
#dk31
	bne $t0, $t3, else_30
# t0=12 => reset t0=0
	addi $t0, $zero, 0
	j else_30
if_30:
# a3=0 =>cung chieu kim dong ho
	addi $t0, $t0, -1
# so sanh t0 voi -1
	addi $t3, $zero, -1
# dk32
	bne $t0, $t3, else_30
# t0=-1 => reset t0=11
	addi $t0, $zero, 11
else_30:
#---------------------------------------------
	beq $t2, $zero, rai_quan
# tra ve ket qua vao v0
	add $v0, $zero, $t2
#t2=2 => thu quan
	addi $t0, $zero, 2
#dk_20
	bne $t2, $t0, if_20
# --------------------thu quan------------------------------
# thu quan player_0
 #khoi tao while_4
	la $a0, ban_co
	addi $t0, $zero, 5
	lw $t3, point_0
while_6:
#dk_21
	beq $t0, $zero, end_while_6
	sll $t1, $t0, 2
	add $t2, $t1, $a0
	lw $t1, 0($t2)
	sw $zero, 0($t2)
	add $t3, $t3, $t1
	addi $t0, $t0, -1
	j while_6
end_while_6:
	sw $t3, point_0
# thu quan player_1
 #khoi tao while_4
 	la $a0, ban_co
	addi $t0, $zero, 11
	lw $t3, point_1
while_5:
#dk_22
	addi $t1, $zero, 6
	beq $t0, $t1, end_while_5
	sll $t1, $t0, 2
	add $t2, $t1, $a0
	lw $t1, 0($t2)
	sw $zero, 0($t2)
	add $t3, $t3, $t1
	addi $t0, $t0, -1
	j while_5
end_while_5:
	sw $t3, point_1
#-------------------------------------------------------------
if_20:
# tra gia tri t0, t1, t2 tu stack
	lw $t0, 0($sp)
	lw $t1, 4($sp)
	lw $t2, 8($sp)
	lw $t3, 12($sp)
	addi $sp, $sp, 16
#tra ve
	jr $ra
#----------------------------------------------------------
#---------------------end_funct----------------------------
#----------------------------------------------------------	
#----------------------------------------------------------
#---------------------checkTerminate----------------------------
#--------------------------------------------------------
#tra ve  0 => tiep tuc rai
#	 1 => ket thuc luot
#	 2 => ket thuc van
checkTerminate:
# a1 chua nguoi choi, $a2 chua o hien tai, $a3 chua huong
# luu gia tri t0 t1 t2 s3 vao stack
	addi $sp, $sp, -20
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	sw $t2, 8($sp)
	sw $s3, 12($sp)
	sw $t3, 16($sp)
# t3: flag xem da co an diem chua
	addi $t3, $zero, 1
# s3 luu gia tri tra ve																														
# t0 se luu vi tri hien tai
	add $t0, $zero, $a2
	
#-----------tang gia tri cua o hien tai----------------
while_3:

#dk6
	beq $a3, $zero, if_6
# a3=1 =>nguoc chieu kim dong ho
	addi $t0, $t0, 1
# so sanh t0 voi 12
	addi $t2, $zero, 12
#dk7
	bne $t0, $t2, else_6
# t0=12 => reset t0=0
	addi $t0, $zero, 0
	j else_6
	
if_6:
# a3=0 =>cung chieu kim dong ho
	addi $t0, $t0, -1
# so sanh t0 voi -1
	addi $t2, $zero, -1
# dk8
	bne $t0, $t2, else_6
# t0=-1 => reset t0=11
	addi $t0, $zero, 11
else_6:
#---------------------------------------------
# t1 chua so quan trong o hien tai
	la $a0, ban_co
	sll $t1, $t0, 2
	add $a0, $a0, $t1
	lw $t1, 0($a0)		
# kiem tra xem o do co trong khong
# dk9	
	beq $t1, $zero, if_9	
# t1>0 => o hien tai khong trong
# kiem tra co xem da an diem lan nao chua => neu roi thi kiem tra dk dung
	beq $t3, $zero, check_end_game
# kiem tra xem o do co la o quan khong (0 hoac 6)
# dk10 ss voi 0
	beq $t0, $zero, check_end_game
# dk11 ss voi 6
	addi $t2, $zero, 6
	beq $t0, $t2, check_end_game
# khong phai o quan => tiep tuc rai =>tra ve 0	
	addi $s3, $zero, 0
	j out_checkTerminal
if_9:
# t1=0 => o hien tai trong
#-----------tang gia tri cua o hien tai----------------
#dk12
	beq $a3, $zero, if_12
# a3=1 =>nguoc chieu kim dong ho
	addi $t0, $t0, 1
# so sanh t0 voi 12
	addi $t2, $zero, 12
#dk13
	bne $t0, $t2, else_12
# t0=12 => reset t0=0
	addi $t0, $zero, 0
	j else_12
	
if_12:
# a3=0 =>cung chieu kim dong ho
	addi $t0, $t0, -1
# so sanh t0 voi -1
	addi $t2, $zero, -1
# dk14
	bne $t0, $t2, else_12
# t0=-1 => reset t0=11
	addi $t0, $zero, 11
else_12:
# t1 chua so quan trong o hien tai
	la $a0, ban_co
	sll $t1, $t0, 2
	add $a0, $a0, $t1
	lw $t1, 0($a0)	
	sw $zero, 0($a0)
	
#dk 15
	bne $t1, $zero, if_15
# neu o hien tai trong (sau khi tang 1)=>dung luot => kiem tra ket thuc van
	j check_end_game
if_15:
# neu o hien tai co quan => tang diem =>lap lai
# tang diem
# dk_16
	bne $a1, $zero, if_16
# player_0
	lw $t2, point_0
	add $t1, $t2, $t1
# neu >=900 thi -1000 + 10
	addi $t2, $zero, 900
	slt $t2, $t1, $t2
#dk_28
	bne $t2, $zero, if_28
# t1>=900
	addi $t1, $t1, -1000
	addi $t1, $t1, 10	
if_28:
#t1<900
	sw $t1, point_0
	j else_16
# player_1
if_16:
	lw $t2, point_1
	add $t1, $t2, $t1
# neu >900 thi -1000 + 10
	addi $t2, $zero, 900
	slt $t2, $t1, $t2
#dk_29
	bne $t2, $zero, if_29
# t1>=900
	addi $t1, $t1, -1000
	addi $t1, $t1, 10	
if_29:
#t1<1000
	sw $t1, point_1
else_16:
# lap lai
# turn on flag t3
	addi $t3, $zero, 0
	j while_3

# kiem tra dk ket thuc van
# neu 2 o quan khong con quan thi ket thuc van	
check_end_game:
	addi $s3, $zero, 1
#----------kiem tra 2 o quan co trong hay khong-------
	la $a0, ban_co
# xem o so 0 co chua quan hay khong (<1 ?)
	lw $t0, 0($a0)
	addi $t1, $zero, 1
	slt $t2, $t0, $t1
# xem o so 6 co chua quan hay khong (<1 ?)
	lw $t0, 24($a0)
	slt $t0, $t0, $t1
	
	and $t0, $t0, $t2		
	beq $t0, $zero, check_quan_tren_ban_co
	addi $s3, $zero, 2
	j out_checkTerminal
#-------------------kiem tra co con quan tren ban co khong----------------
check_quan_tren_ban_co:
	addi $t0, $zero, 11
	la $s1, ban_co
		
while_4:
#dk_17
	beq $t0, $zero, end_while_4	
	sll $t2, $t0, 2
	add $t2, $t2, $a0
	lw $t1, 0($t2)	
#dk_18
	bne $t1, $zero, out_checkTerminal
	addi $t0, $t0, -1
	j while_4
end_while_4:
# ket thuc tro choi
	addi $s3, $zero, 2
out_checkTerminal:
	
#tra ve
	add $v0, $zero, $s3
	add $s5, $zero, $s3
# tra gia tri t0, t1, t2, s0 tu stack
	lw $t0, 0($sp)
	lw $t1, 4($sp)
	lw $t2, 8($sp)
	lw $t3, 12($sp)
	lw $t4, 16($sp)
	addi $sp, $sp, 20
	jr $ra
#----------------------------------------------------------
#---------------------end_funct----------------------------
#--------------------------------------------------------	
#----------------------------------------------------------
#---------------------print----------------------------
#-------------------------------------------------------
print:
### Cap nhat lai ban co de hien thi
    # Xu li 2 ô quan
    	la	$a0,ban_co
    	lw 	$s7,No.10	# thanh ghi s7 chua gia tri 10.
    # Xu li o quan tai vi tri ban_co[0]
Update_madarin_0:
    	lw 	$t5,0($a0)	# t5 chua gia tri tai vi tri ban_co[0]
    	slti	$t6,$t5,1000	# neu t5 < 1000 thi t6 = 1, nguoc lai t6 = 0
    	bnez 	$t6,Label_0
    	li	$t7,4
    	li	$s4,1
    #goi ham
	addi $s4,$s4,48		
	sb $s4,gach4($t7)	
    	subi	$t5,$t5,1000
    	div	$s4,$t5,$s7
    	li	$t7,3
    #goi ham
	addi $s4,$s4,48		# Chuyen s4 tu so nguyen sang ki tu 
	sb $s4,gach2($t7)	# luu vao gach2
	
   	subi	$s4,$s4,48	# Chuyen S4 tu ki tu sang so nguyen
   	mul	$s4,$s4,$s7	# Nhan S4 cho 10
   	sub	$s4,$t5,$s4
   	addi	$t7,$t7,1
    #goi ham
	addi $s4,$s4,48		
	sb $s4,gach2($t7)	
    	j	Update_madarin_1
   Label_0:
   	li 	$t7,4
   	li	$s4,0
    #goi ham
	addi $s4,$s4,48		
	sb $s4,gach4($t7)	
	
   	div	$s4,$t5,$s7	# Chia ban_co[0] cho 10 luu vao $s4
   	li	$t7,3
    #goi ham
	addi $s4,$s4,48		
	sb $s4,gach2($t7)	
	
   	subi	$s4,$s4,48	# Chuyen S4 tu ki tu sang so nguyen
   	mul	$s4,$s4,$s7	# Nhan S4 cho 10
   	sub	$s4,$t5,$s4
   	addi	$t7,$t7,1
    #goi ham
	addi $s4,$s4,48		
	sb $s4,gach2($t7)	
Update_madarin_1:
    	lw 	$t5,24($a0)	# thanh ghi t5 chua gia tri cua ban_co[6]
    	slti	$t6,$t5,1000	# neu t5 < 1000 thi t6 = 1, nguoc lai t6 = 0
    	bnez 	$t6,Label_1
    	li	$t7,34		# vi tri can thay
    	li	$s4,1
    #goi ham
	addi $s4,$s4,48		
	sb $s4,gach4($t7)	
	
    	subi	$t5,$t5,1000
    	div	$s4,$t5,$s7
    	li	$t7,33
    #goi ham
	addi $s4,$s4,48		
	sb $s4,gach2($t7)	
	
   	subi	$s4,$s4,48	# Chuyen S4 tu ki tu sang so nguyen
   	mul	$s4,$s4,$s7	# Nhan S4 cho 10
   	sub	$s4,$t5,$s4
   	addi	$t7,$t7,1
    #goi ham
	addi $s4,$s4,48		
	sb $s4,gach2($t7)	
   	j 	Update_civilian_0
    	
   Label_1:
   	li 	$t7,34
   	li	$s4,0
    #goi ham
	addi $s4,$s4,48		
	sb $s4,gach4($t7)	

   	div	$s4,$t5,$s7	# Chia ban_co[0] cho 10 luu vao $s4
   	li	$t7,33
    #goi ham
	addi $s4,$s4,48		
	sb $s4,gach2($t7)	
	
   	subi	$s4,$s4,48	# Chuyen S4 tu ki tu sang so nguyen
   	mul	$s4,$s4,$s7	# Nhan S4 cho 10
   	sub	$s4,$t5,$s4
   	addi	$t7,$t7,1
    #goi ham
	addi $s4,$s4,48		
	sb $s4,gach2($t7)	
    ### Xu li cac o dan
    # Xu li cac o dan cua nguoi choi 1 (tu o 1 -> 5)
Update_civilian_0:
	li	$t7,8
	li	$t8,4		# 4 byte dai dien cho vi tri ban_co[1]	
	li 	$s1,24		# 24 byte dai dien cho vi tri ban_co[6]
Loop_0:
	beq	$t8,$s1,Update_civilian_1
	lw	$t5,ban_co($t8)
	div	$s4,$t5,$s7
    #goi ham
	addi $s4,$s4,48		
	sb $s4,gach4($t7)	
	
	subi	$s4,$s4,48
	mul	$s4,$s4,$s7
	sub	$s4,$t5,$s4
	addi	$t7,$t7,1
    #goi ham
	addi $s4,$s4,48		
	sb $s4,gach4($t7)	
	
	addi	$t7,$t7,4
	addi	$t8,$t8,4	# tang them 4 byte dong nghia voi chuyen sang vi tri tiep theo
	j	Loop_0
    # Xu li cac o dan cua nguoi choi 2 (tu o 7 ->11)
Update_civilian_1:
	li	$t7,28		# vi tri bat dau thay doi cua o thu 7
	li	$t8,28		# 28 byte dai dien cho vi tri cua ban_co[7]
	li	$s1,48
Loop_1:
	beq	$t8,$s1,printChessBoard
	lw	$t5,ban_co($t8)
	div	$s4,$t5,$s7
    # goi ham	
	addi 	$s4,$s4,48		
	sb 	$s4,gach2($t7)	
	
	subi	$s4,$s4,48
	mul	$s4,$s4,$s7
	sub	$s4,$t5,$s4
	addi	$t7,$t7,1
    #goi ham	
	addi 	$s4,$s4,48		
	sb 	$s4,gach2($t7)	
	
	subi	$t7,$t7,6
	addi	$t8,$t8,4
	j	Loop_1
### In ban co
printChessBoard:
	la $a0,gach1
	li $v0,4
	syscall
	la $a0,gach2
	li $v0,4
	syscall
	la $a0,gach3
	li $v0,4
	syscall
	la $a0,gach4
	li $v0,4
	syscall
	la $a0,gach5
	li $v0,4
	syscall
### In diem cua nguoi choi
	la $a0, in_diem_hien_tai
	addi $v0, $zero, 4
	syscall
		
	lw $a0, point_0
	addi $v0, $zero, 1
	syscall
	
	la $a0, ngan_cach
	addi $v0, $zero, 4
	syscall
	
	lw $a0, point_1
	addi $v0, $zero, 1
	syscall
	
	addi $a0, $zero, '\n'
	addi $v0, $zero, 11
	syscall	
# return
#in xuong dong
	addi $a0, $zero, '\n'
	addi $v0, $zero, 11
	syscall
	
	jr $ra
#----------------------------------------------------------
#---------------------end_funct----------------------------
#--------------------------------------------------------
#----------------------------------------------------------
#---------------------print_result----------------------------
#-------------------------------------------------------
print_result:
#luu vao stack
	addi $sp, $sp, -8
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	
	lw $t0, point_0
	lw $t1, point_1
	la $a0, in_ket_qua
	addi $v0, $zero, 4
	syscall
	
	lw $a0, point_0
	addi $v0, $zero, 1
	syscall
	
	addi $a0, $zero, '-'
	addi $v0, $zero, 11
	syscall
	
	lw $a0, point_1
	addi $v0, $zero, 1
	syscall
#dk_21
	bne $t0, $t1, if_21
# hoa nhau
	la $a0, in_hoa
	addi $v0, $zero, 4
	syscall	
	j else_21
if_21:
# khong hoa
	la $a0, in_winner
	addi $v0, $zero, 4
	syscall	
	
	slt $t0, $t0, $t1
#dk_22
	bne $t0, $zero, if_22
# player 0 win
	la $a0, player_0
	addi $v0, $zero, 4
	syscall	
	j else_21
if_22:
# player 1 win	
	la $a0, player_1
	addi $v0, $zero, 4
	syscall		
else_21:
#tra ve
	lw $t0, 0($sp)
	lw $t1, 4($sp)
	addi $sp, $sp, 8
	jr $ra
#----------------------------------------------------------
#---------------------end_funct----------------------------
#-------------------------------------------------------
#----------------------------------------------------------
#---------------------check_have_to_borrow----------------------------
#-------------------------------------------------------

#tra ve 0 neu khong borrow
#	1 neu borrow
check_to_borrow:
	add $v0, $zero, $zero
# a1 luu luot
#luu vao stack
	addi $sp, $sp, -12
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	sw $t2, 8($sp)
#dk_23
	bne $a1, $zero, if_23
	
# player_0 turn
# vong lap 7
# khoi tao while 7
	la $a0, ban_co
	addi $t0, $zero, 5
while_7:
#dk_24
	beq $t0, $zero, end_while_7
	sll $t1, $t0, 2
	add $t1, $t1, $a0
	lw $t1, 0($t1)
#dk_25
	bne $t1, $zero, no_borrow
	addi $t0, $t0, -1
	j while_7
end_while_7:
#--------------borrow-------------------------
	addi $v0, $zero, 1
# vong lap 8
# khoi tao while 8
	la $a0, ban_co
	addi $t0, $zero, 5
while_8:
#dk_24
	beq $t0, $zero, end_while_8
	sll $t1, $t0, 2
	add $t1, $t1, $a0
	addi $t2, $zero, 1
	sw $t2, 0($t1)
	addi $t0, $t0, -1
	j while_8
end_while_8:	
# tru diem
	lw $t0, point_0
	addi $t0, $t0, -5
	sw $t0, point_0
	j else_23
if_23:
# player_1 turn
# vong lap 9
# khoi tao while 9
	la $a0, ban_co
	addi $t0, $zero, 11
	addi $t2, $zero, 6
while_9:
#dk_24
	beq $t0, $t2, end_while_9
	sll $t1, $t0, 2
	add $t1, $t1, $a0
	lw $t1, 0($t1)
#dk_25
	bne $t1, $zero, no_borrow
	addi $t0, $t0, -1
	j while_9
end_while_9:
#--------------borrow-------------------------
	addi $v0, $zero, 1
# vong lap 10
# khoi tao while 10
	la $a0, ban_co
	addi $t0, $zero, 11
while_10:
#dk_24
	addi $t2, $zero, 6
	beq $t0, $t2, end_while_10
	sll $t1, $t0, 2
	add $t1, $t1, $a0
	addi $t2, $zero, 1
	sw $t2, 0($t1)
	addi $t0, $t0, -1
	j while_10
end_while_10:
# tru diem
	lw $t0, point_1
	addi $t0, $t0, -5
	sw $t0, point_1
else_23:

no_borrow:
#tra ve
	lw $t0, 0($sp)
	lw $t1, 4($sp)
	lw $t2, 8($sp)
	addi $sp, $sp, 8
	jr $ra
#----------------------------------------------------------
#---------------------end_funct----------------------------
#----------------------------------------------------------
#----------------------------------------------------------
#------------------------reset----------------------------
#----------------------------------------------------------
reset:
	la $a0, ban_co
# khoi tao vong lap while
	addi $t0, $zero, 11
	addi $t2, $zero, 5
while_11:
	sll $t1, $t0, 2
	add $t1, $t1, $a0
	sw $t2, 0($t1)
	beq $t0, $zero, out_while_11
	addi $t0, $t0, -1
	j while_11
out_while_11:
	addi $t0, $zero, 1000
	sw $t0, 0($a0)
	sw $t0, 24($a0)
	
#reset diem
	sw $zero, point_0
	sw $zero, point_1
# tra ve
	jr $ra
#----------------------------------------------------------
#---------------------end_funct----------------------------
#----------------------------------------------------------



