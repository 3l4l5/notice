# -*- coding: utf-8 -*-
from notify import send_message


url = "https://condition.nihon-u.ac.jp/Student"
send_message("\nもう熱測りましたか？？？\nまだ熱測ってない人は測って記録してね！\n"+url)

if __name__ == "__main__":
    send_message("今日から午前10時と午後６時に熱を測るよう自動で通知します！\nみんなしっかりと熱を測って卒業式に出ましょう！\n"+url)