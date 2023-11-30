bits 64

extern MessageBeep
extern MessageBoxA
extern ExitProcess
extern InitWindow
extern BeginDrawing
extern ClearBackground
extern EndDrawing
extern DrawText
extern WindowShouldClose
extern SetTargetFPS
extern DrawRectangle
extern IsKeyDown

start:
  sub rsp, 8

  sub rsp, 32
  mov rcx, 0
  call [MessageBeep]
  add rsp, 32

gamestart:

  sub rsp, 32
  mov rcx, 1024
  mov rdx, 768
  mov r8, wintitle
  call [InitWindow]

  mov rcx, 60
  call [SetTargetFPS]

  add rsp, 32

gameloop:

  sub rsp, 32

  call [WindowShouldClose]
  cmp rax, 0
  jnz end

moveplayer:

  mov rcx, 87 ; W
  call [IsKeyDown]
  sub [playery], rax

  mov rcx, 83 ; S
  call [IsKeyDown]
  add [playery], rax

  mov rcx, 65 ; A
  call [IsKeyDown]
  sub [playerx], rax

  mov rcx, 68 ; D
  call [IsKeyDown]
  add [playerx], rax

  mov rcx, 32 ; SPACE
  call [IsKeyDown]
  cmp rax, 0
  jnz shoot

aftershoot:

  cmp byte [shooted], 1
  jnz aftermoveprojectile
  sub qword [projectiley], 10

  cmp qword [projectiley], -10
  jl resetshoot

aftermoveprojectile:

startdraw:
  call [BeginDrawing]
  mov rcx, 0xFF282223 ;32 BITS
  mov rdx, 768
  mov r8, wintitle
  call [ClearBackground]

drawplayer:

  mov rcx, [playerx]
  mov rdx, [playery]
  mov r8, 50
  mov r9, 50

  sub rsp, 8  
  mov rax, 0xFF54c0e3
  push rax
  sub rsp, 32
  call [DrawRectangle]
  add rsp, 32
  add rsp, 8
  pop rax

drawprojectile:
  mov rcx, [projectilex]
  mov rdx, [projectiley]
  mov r8, 10
  mov r9, 10

  sub rsp, 8  
  mov rax, 0xFF4650c6
  push rax
  sub rsp, 32
  call [DrawRectangle]
  add rsp, 32
  add rsp, 8
  pop rax

enddraw:
  call [EndDrawing]

  add rsp, 32

jmp gameloop

end:
  sub rsp, 32
  mov rcx, 100
  call [ExitProcess]
  add rsp, 32

  ret

shoot:
  cmp byte [shooted], 0
  jnz aftershoot

  mov rcx, [playerx]
  mov [projectilex], rcx
  mov rcx, [playery]
  mov [projectiley], rcx
  
  add qword [projectilex], 20
  sub qword [projectiley], 5
  mov byte [shooted], 1

jmp aftershoot

resetshoot:
  mov byte [shooted], 0 

jmp aftershoot

section .data
boxmessage:
db "Hello world!!!", 0
wintitle:
db "Shooter game", 0

playerx:
dq (1024-50)/2
playery:
dq (768-50)/2
projectilex:
dq -10
projectiley:
dq -10
shooted:
db 0