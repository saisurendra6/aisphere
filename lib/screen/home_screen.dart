import 'package:aisphere/model/gemini_model.dart';
import 'package:aisphere/model/message_model.dart';
import 'package:aisphere/widgets/chat_bubble.dart';
import 'package:aisphere/widgets/reply_bubble.dart';
import 'package:aisphere/widgets/user_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TextEditingController _promptInputController;
  late final ScrollController _scrollController;
  List<String> models = ["Gemini", "Lamma", "GPT", "deepseek"];
  String selectedModel = "Gemini";
  bool isLoading = false;
  final List<MessageModel> hist = [];

  @override
  void initState() {
    _promptInputController = TextEditingController();
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _promptInputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // print("size: $size");
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.6),
              borderRadius: BorderRadius.circular(16)),
          child: DropdownButton(
              value: selectedModel,
              items: models
                  .map((item) => DropdownMenuItem(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ))
                  .toList(),
              underline: const SizedBox(),
              onChanged: (val) {
                setState(() {
                  selectedModel = val!;
                });
              }),
        ),
        centerTitle: true,
      ),
      drawer: const Drawer(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Column(
              children: [
                UserCard(
                  name: "Alice",
                  email: "alice@email.com",
                  picUrl: "",
                ),
                Divider(),
                Spacer(flex: 4),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: (hist.isEmpty)
                  ? const Center(child: Text("Hello There..!"))
                  : Scrollbar(
                      controller: _scrollController,
                      child: ListView.builder(
                        itemCount: hist.length,
                        itemBuilder: (context, i) => ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: size.width * 0.8,
                            ),
                            child: (hist[i].isPrompt)
                                ? ChatBubble(prompt: hist[i].message)
                                : ReplyBubble(response: hist[i].message)),
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _promptInputController,
                // maxLength: 100,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(8.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0)),
                  prefixIcon:
                      IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
                  suffixIcon: IconButton(
                      onPressed: sendPrompt,
                      icon: isLoading
                          ? const CircularProgressIndicator()
                          : const Icon(Icons.send_rounded)),
                ),
                onSubmitted: (val) => sendPrompt,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void sendPrompt() async {
    String prompt = _promptInputController.text.trim();
    if (prompt.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      hist.add(MessageModel(isPrompt: true, message: prompt));
      String res = await GeminiModel.generateContent(prompt);
      _promptInputController.clear();
      hist.add(MessageModel(isPrompt: false, message: res));
      setState(() {
        isLoading = false;
      });
    }
  }
}
