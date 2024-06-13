section	.text
   global _start         ;must be declared for using gcc
	
_start:                  ;tell linker entry point
   ;create the file
   mov  eax, 8
   mov  ebx, file_name
   mov  ecx, 0777        ;read, write and execute by all
   int  0x80             ;call kernel
	
   mov [fd_out], eax
    
   ; write into the file
   mov	edx, len         ;number of bytes
   mov	ecx, msg         ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel

   ; close the file
   mov eax, 6
   mov ebx, [fd_out]
       
   mov	eax,1             ;system call number (sys_exit)
   int	0x80              ;call kernel

section	.data
file_name db 'keyvault.bicep'
msg db 'resource keyVault ',`\u0027`,'Microsoft.KeyVault',`\u002f`,'vaults',`\u0040`,'2021-10-01',`\u0027`,' = {',13,10,'name: ',`\u0027`,'keyvaultName',`\u0027`,13,10,'location: ',`\u0027`,'norwayeast',`\u0027`,13,10,'properties: {',13,10,'sku: {',13,10,'family: ',`\u0027`,'A',`\u0027`,13,10,'name: ',`\u0027`,'standard',`\u0027`,13,10,'}',13,10,'tenantId: subscription().tenantId',13,10,'}',13,10,'}',0xa
len equ  $-msg

section .bss
fd_out resb 1
